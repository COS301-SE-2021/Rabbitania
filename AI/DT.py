import threading
import tensorflow_decision_forests as tfdf
import pandas
from tensorflow import keras
import tensorflow as tf
from tensorflow.keras.models import load_model
import numpy as np
from flask import Flask, jsonify, request 
import json
from pandas.io.json import json_normalize
import os
from flask_cors import CORS
import nltk, string
from sklearn.feature_extraction.text import TfidfVectorizer
nltk.download('punkt')


app = Flask(__name__)
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

@app.route("/index")
def index():
    return "Flask app running"

class DecisionTree:
    def __init__(self):
        self.model_path = 'models'
        
    def train_and_save(self):
        #Training dataset
        train_df = pandas.read_csv("dataset4.csv")
        train_ds = tfdf.keras.pd_dataframe_to_tf_dataset(train_df, label="corona_result")

        #Evaluating dataset
        evaluate_data = pandas.read_csv("dataset3.csv")
        evaluate_dataset = tfdf.keras.pd_dataframe_to_tf_dataset(evaluate_data, label="corona_result")

        #Train Random Forest using train_ds
        #model = tfdf.keras.RandomForestModel()
        model=tfdf.keras.GradientBoostedTreesModel()
        model.fit(train_ds)

        model.summary()
        # Evaluate
        model.compile(metrics=["accuracy"])
        print(model.evaluate(evaluate_dataset))
        # >> 0.97

        model.save(self.model_path)

        # print(model)
        return model

    def importModel(self):
        loadModel = tf.keras.models.load_model(self.model_path)
        return loadModel

    def predictionTest(self):
        print("loading model from "+self.model_path)
        loadedModel = self.importModel()

        print("model loaded successfully")
        Dataset = pandas.read_csv("test.csv")

        ConvertedData = tfdf.keras.pd_dataframe_to_tf_dataset(Dataset)

        print("Predicting from test.csv")
        predictions = loadedModel.predict(ConvertedData)
        print("-------------------------------------------------------------Predictions---------------------------------------------------------")
        print(predictions)
    
    def prediction(self, UserSymptoms):
        print("loading model from "+self.model_path)
        loadedModel = self.importModel()
        print("model loaded successfully")

        print("Converting input to Dataframe")
        df=pandas.json_normalize(UserSymptoms)
        df.to_csv("data.csv", index = False)
        dataframe = pandas.read_csv("data.csv")
        ConvertedData = tfdf.keras.pd_dataframe_to_tf_dataset(dataframe)

        prediction = loadedModel.predict(ConvertedData)
        print("------------------------Prediction------------------------")
        
        finalPrediction = prediction[0][0]
        print(finalPrediction)
        return json.dumps(str(finalPrediction))
        

@app.route('/api/train', methods=['GET'])
def train():
    #declare object of DecisionTree class
    dt = DecisionTree()
    #train model and save it in 'models'
    dt.train_and_save()
    dt.predictionTest()
    return "trained model and saved to models"

@app.route('/api/predict', methods=['POST'])
def userPrediction():
    dt = DecisionTree()
    psymptoms = request.get_json()
    return dt.prediction(psymptoms)

@app.route('/api/tfidf', methods=['GET'])
def respond():
    threadTitle = request.args.get("threadTitle").split(',')
    threadBody = request.args.get("threadBody").split(',')
    newThreadTitle = request.args.get("newThreadTitle")
    newThreadBody = request.args.get("newThreadBody")

    response = {}
    stemmer = nltk.stem.porter.PorterStemmer()

    #Remove unnecessary punctuation from the body of text
    remove_punctuation_map = dict((ord(char), None) for char in string.punctuation)

    #Stemmer will remove unnecessary characters from words and act as a filter.
    def stem_tokens(tokens):
        return [stemmer.stem(item) for item in tokens]

    #tokenize the body of text after removing punctuation, and making the entire text lower case
    def normalize(text):
        return stem_tokens(nltk.word_tokenize(text.lower().translate(remove_punctuation_map)))

    # vectorize the given bodies of text, removing words that are most prevelant in the english language such as 'a' and 'the', 
    # in order to leave only the most important words.
    vectorizer = TfidfVectorizer(tokenizer=normalize, stop_words='english')


    #Calculate the cosine similarity between the two vectors
    def cosine_sim(text1, text2):
        tfidf = vectorizer.fit_transform([text1, text2])
        return (tfidf * tfidf.T)[0,1]

    count = 0
    total_cosine = 0.0
    
    for i in range (0, len(threadTitle)):
        cosine_similarity = cosine_sim(newThreadTitle, threadTitle[i])
        print(cosine_similarity)
        if(cosine_similarity > 0.5):
            return "true"
    
    for i in range (0, len(threadBody)):
        cosine_similarity = cosine_sim(newThreadBody, threadBody[i])
        print(cosine_similarity)
        if(cosine_similarity > 0.5):
            return "true"
    
    return "false"


if __name__ == '__main__':
    Port = os.getenv('PORT')
    app.run(threaded = True,host='0.0.0.0' ,port = Port)
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
    
if __name__ == '__main__':
    Port = os.getenv('PORT')
    app.run(threaded = True,host='0.0.0.0' ,port = Port)
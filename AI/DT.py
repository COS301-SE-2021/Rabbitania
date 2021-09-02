import threading

from pandas.core.frame import DataFrame
import tensorflow_decision_forests as tfdf
import pandas
from tensorflow import keras
import tensorflow as tf
from keras.models import load_model
import numpy as np
from flask import Flask, jsonify, request 
import json
from pandas.io.json import json_normalize

app = Flask(__name__)

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

        model.make_inspector().export_to_tensorboard("tensorboard_logs")

        tfdf.model_plotter.plot_model(model, tree_idx=0, max_depth=3)
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
        jsonData = UserSymptoms
        cough = jsonData.get('cough','')
        fever = jsonData.get('fever', '')
        sore_throat = jsonData.get('sore_throat','')
        shortness_of_breath = jsonData.get('shortness_of_breath','')
        head_ache = jsonData.get('head_ache', '')
        input = [cough, fever,sore_throat,shortness_of_breath, head_ache]


        #print("loaded test.json")
        #df = pandas.DataFrame.from_dict(UserSymptoms).reset_index()
        df = pandas.read_json(jsonData)
        print(df)

        prediction = loadedModel.predict(df)
        print("------------------------Prediction------------------------")
        print(prediction)
        return prediction


dt = DecisionTree()    
#dt.train_and_save()
#dt.predictionTest()


@app.route('/api/train', methods=['GET'])
def train():
    #declare object of DecisionTree class
    dt = DecisionTree()
    #train model and save it in 'models'
    dt.train_and_save()
    return "Training completed and model saved to models directory"

@app.route('/api/predict', methods=['POST'])
def userPrediction():
    dt = DecisionTree()
    psymptoms = request.get_data()
    print(psymptoms)
    return dt.prediction(psymptoms)
    
if __name__ == '__main__':
    app.run(threaded = True, port = 5006)
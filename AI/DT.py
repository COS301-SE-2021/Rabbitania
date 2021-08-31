import threading
import tensorflow_decision_forests as tfdf
import pandas
from tensorflow import keras
import tensorflow as tf
from keras.models import load_model
import numpy as np
from flask import Flask, jsonify, request 

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

    def prediction(self):
        print("loading model from "+self.model_path)
        loadedModel = self.importModel()

        print("model loaded successfully")
        Dataset = pandas.read_csv("test.csv")

        ConvertedData = tfdf.keras.pd_dataframe_to_tf_dataset(Dataset)

        print("Predicting from test.csv")
        predictions = loadedModel.predict(ConvertedData)
        print("-------------------------------------------------------------Predictions---------------------------------------------------------")
        print(predictions)
    
dt = DecisionTree()    
dt.train_and_save()
dt.prediction()

@app.route('/api/predict/', methods = ['GET'])
def assumption():
    dt = DecisionTree()

    dt.train_and_save()
    dt.prediction()
    data = request.get_json()
    cough = request.args.get("cough")
    fever = data.get('fever','')
    sore_throat = data.get('sore_throat','')
    shortness_of_breath = data.get('shortness_of_breath')
    head_ache = data.get('head_ache')
    gender = data.get('gender')
    test_indication = data.get('test_indication')
    symptoms = [cough,fever, sore_throat, shortness_of_breath, head_ache, gender, test_indication]
    dt.prediction(symptoms)
    return "hello there"


# if __name__ == '__main__':
#     app.run(threaded = True, port = 5006)
#dt.exportToBoard()


    


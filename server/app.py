from flask import Flask, request
from flask_json import FlaskJSON, JsonError, json_response
from keras.models import load_model
import base64
import numpy as np
import tensorflow as tf
tf.python.control_flow_ops = tf

app = Flask(__name__)
json = FlaskJSON(app)
app.secret_key = 'super_secret_key'
global graph

def read_image(data):
    buf = base64.decodestring(data['image'])
    return np.frombuffer(buf, dtype=np.float64).reshape(1, 28, 28, 1)


def predict_with_keras(image):
    prediction = model.predict_proba(image)
    return np.argmax(prediction, axis=1)[0]


@app.route('/predict', methods=["POST"])
def predict():
    with graph.as_default():
        data = request.get_json(force=True)
        image = read_image(data)
        number = predict_with_keras(image)
        return json_response(number=number)

if __name__ == '__main__':
    app.debug = True
    model = load_model('/model/final_model.h5')

    # Store graph to allow inference in a different thread:
    # https://github.com/fchollet/keras/issues/2397
    graph = tf.get_default_graph()

    app.run(host='0.0.0.0', port=5000)

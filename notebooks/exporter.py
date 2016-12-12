from keras import backend as K
from keras.models import load_model, model_from_config, Sequential
from tensorflow.contrib.session_bundle import exporter
import tensorflow as tf
tf.python.control_flow_ops = tf

model_path = 'cache/notebook/final_model.h5'
export_path = 'cache/model'
export_version = 1

# load keras model
model = load_model(model_path)
config = model.get_config()
weights = model.get_weights()

# fix test mode and rebuild
K.set_learning_phase(0)
model = Sequential.from_config(config)
model.set_weights(weights)

# export to tensorflow
sess = K.get_session()
saver = tf.train.Saver(sharded=True)
model_exporter = exporter.Exporter(saver)
signature = exporter.classification_signature(input_tensor=model.input,
                                              scores_tensor=model.output)
model_exporter.init(sess.graph.as_graph_def(),
                    default_graph_signature=signature)
model_exporter.export(export_path, tf.constant(export_version), sess)

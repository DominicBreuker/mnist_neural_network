# Deep Learning with MNIST example

Simple example illustrating a neural network development workflow.
Uses MNIST as a dataset and is based on the corresponding [Kaggle challenge](https://www.kaggle.com/c/digit-recognizer).

Check out this notebook first: [Deep Learning with MNIST](https://dominicbreuker.github.io/mnist_neural_network)

The goal is to take a 28x28 grayscale image of a single handwritten digit form 0 to 9 as input and predict which digit it is.
The solution is a convolutional neural network created with [Keras](https://keras.io/) backed by [TensorFlow](https://www.tensorflow.org/).
It's architecture is based on [LeNet](http://yann.lecun.com/exdb/lenet/) and a few different sizes are compared during model selection.
The final model's accuracy on the Kaggle test set will be around 0.992.

## Model development
- [Model development](notebooks/Deep\ Learning\ with\ MNIST.ipynb): Jupyter notebook with data exploration, preprocessing, augmentation, model fitting and evaluation results. Run with `bin/run.sh` to start the development docker container. Then go to `http://localhost:8888` to see the notebook.

## Model deployment
- [REST deployment](server/ap.py): Example of a flask app making Keras models available as a REST API. Start the server with `bin/deploy_flash.sh` and it will be available at `http://localhost:5000/predict`.
- [RPC deployment](bin/deploy_tensorflow_serving): (Highly) experimental deployment of a Keras model with [Tensorflow Serving](https://tensorflow.github.io/serving/). Will make the model available as a [gRPC](http://www.grpc.io/) service. Start with `bin/deploy_tensorflow_serving.sh`

All dependencies are dockerized to make setup easy and facilitate reproducibility.
The Dockerfiles are in the `docker` folder.

Note: due to file size constrains, use `bin/join.sh` after checking out the repository to combine the model files in `cache/notebook`. They have been split with `bin/split.sh` before uploading to GitHub as their size is slightly above maximum file size.

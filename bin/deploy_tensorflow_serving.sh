#!/bin/bash

script="$0"
FOLDER="$(pwd)/$(dirname $script)"

source $FOLDER/utils.sh
PROJECT_ROOT="$(abspath $FOLDER/..)"
echo "project root folder $PROJECT_ROOT"

echo "build docker image"
/bin/bash $FOLDER/build_deploy_tensorflow_serving.sh

##### Prepare #####

echo "exporting model to tensorflow"
python $PROJECT_ROOT/notebooks/exporter.py

##### INPUTS #####

# folder containing the model
MODEL_DIR=$PROJECT_ROOT/cache/model
echo "Looking for model in $MODEL_DIR"

##### RUN #####
echo "Staring container..."

docker run -it \
           --rm \
           --name server_tensorflow_serving \
           -p 9000:9000 \
           -v $MODEL_DIR:/model \
           dominicbreuker/tensorflow_serving:latest \
           /serving/bazel-bin/tensorflow_serving/model_servers/tensorflow_model_server --port=9000 --model_name=mnist --model_base_path=/model

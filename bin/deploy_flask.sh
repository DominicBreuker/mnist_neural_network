#!/bin/bash

script="$0"
FOLDER="$(pwd)/$(dirname $script)"

source $FOLDER/utils.sh
PROJECT_ROOT="$(abspath $FOLDER/..)"
echo "project root folder $PROJECT_ROOT"

echo "build docker image"
/bin/bash $FOLDER/build_deploy_flask.sh

##### INPUTS #####

# folder containing the model
MODEL_DIR=$PROJECT_ROOT/cache/notebook/
echo "Looking for model in $MODEL_DIR"

##### RUN #####
echo "Staring container..."

docker run -it \
           --rm \
           --name server_flask \
           -p 5000:5000 \
           -v $MODEL_DIR:/model \
           dominicbreuker/mnist_flask:latest \
           python app.py

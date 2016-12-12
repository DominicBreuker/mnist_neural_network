#!/bin/bash

script="$0"
FOLDER="$(dirname $script)"

source $FOLDER/utils.sh
PROJECT_ROOT="$(abspath $FOLDER/..)"

echo "building Docker image in folder $PROJECT_ROOT"

docker build -f $PROJECT_ROOT/docker/Dockerfile_deploy_tensorflow_serving \
             -t dominicbreuker/tensorflow_serving:latest \
             $PROJECT_ROOT

#!/bin/bash

script="$0"
FOLDER="$(pwd)/$(dirname $script)"

source $FOLDER/utils.sh
PROJECT_ROOT="$(abspath $FOLDER/..)"
echo "project root folder $PROJECT_ROOT"

echo "build docker image"
/bin/bash $FOLDER/build_develop.sh

##### VOLUMES #####

# folder containing notebooks
NOTEBOOKS_DIR=$PROJECT_ROOT/notebooks
echo "Using notebooks in $NOTEBOOKS_DIR"

# folder containing original train data from kaggle
DATA_DIR=$PROJECT_ROOT/data
echo "Using train and test data in $DATA_DIR"

# folder for file system cache
CACHE_DIR=$PROJECT_ROOT/cache
echo "Caching data in $CACHE_DIR"

##### RUN #####
echo "Staring container..."

docker run -it \
           --rm \
           --name develop \
           -p 8888:8888 \
           -v $DATA_DIR:/data \
           -v $NOTEBOOKS_DIR:/notebooks \
           -v $CACHE_DIR:/cache \
           dominicbreuker/mnist_example:latest \
           sh -c 'jupyter notebook --ip=0.0.0.0 --no-browser --notebook-dir=/notebooks'

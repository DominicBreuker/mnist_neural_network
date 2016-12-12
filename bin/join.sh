script="$0"
FOLDER="$(pwd)/$(dirname $script)"

source $FOLDER/utils.sh
PROJECT_ROOT="$(abspath $FOLDER/..)"
echo "project root folder $PROJECT_ROOT"

cat $PROJECT_ROOT/cache/notebook/best_model.h5.* > $PROJECT_ROOT/cache/notebook/best_model.h5
rm $PROJECT_ROOT/cache/notebook/best_model.h5.*

cat $PROJECT_ROOT/cache/notebook/final_model.h5.* > $PROJECT_ROOT/cache/notebook/final_model.h5
rm $PROJECT_ROOT/cache/notebook/final_model.h5.*

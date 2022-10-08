#!/bin/sh
# The arguments will be passed as tags to the playbook
if [ $# -eq 0 ]
then
    ARGS=""
else
    ARGS="--env TAGS=$1"
fi
IMAGE='setup_penguin:latest' 
docker build --rm . -t $IMAGE
docker run -it $ARGS $IMAGE

#!/bin/sh -xe

IMAGE=akranga/jenkins-java-builder

docker build --no-cache --force-rm -t $IMAGE .
ID=$(docker images $IMAGE | grep latest | awk '{print $3}')
docker tag --force $ID $IMAGE:latest

# cleanup
#RUNNING_CONTAINERS=$(docker ps -a -q)
#docker kill $RUNNING_CONTAINERS
#docker rm $RUNNING_CONTAINERS
#docker rmi $(docker images | grep "^<none>" | awk '{print $3}') 

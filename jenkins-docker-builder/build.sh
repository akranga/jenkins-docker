#!/bin/sh -xe

IMAGE=akranga/jenkins-dind-builder

docker build --no-cache --force-rm -t $IMAGE .
ID=$(docker images $IMAGE | grep latest | awk '{print $3}')
docker tag --force $ID $IMAGE:latest
docker tag --force $ID $IMAGE:1.6.0

# cleanup
#RUNNING_CONTAINERS=$(docker ps -a -q)
#docker kill $RUNNING_CONTAINERS
#docker rm $RUNNING_CONTAINERS
#docker rmi $(docker images | grep "^<none>" | awk '{print $3}') 

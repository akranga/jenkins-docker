#!/bin/sh -xe

IMAGE=akranga/hyperkube:1.0.6

docker build --no-cache --force-rm -t $IMAGE .
ID=$(docker images $IMAGE | grep latest | awk '{print $3}')
docker tag --force $ID $IMAGE:latest

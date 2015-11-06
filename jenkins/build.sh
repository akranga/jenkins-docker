#!/bin/sh -xe
docker build --no-cache --force-rm -t akranga/jenkins .
ID=$(sudo docker images akranga/jenkins | grep latest | awk '{print $3}')
docker tag --force $ID akranga/jenkins:1.609.3
docker tag --force $ID akranga/jenkins:latest

# cleanup
docker kill jenkins | true
docker rm $(docker ps -a -q) | true
docker rmi $(docker images | grep "^<none>" | awk '{print $3}') 

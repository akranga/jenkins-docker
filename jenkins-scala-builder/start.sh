#!/bin/bash

java=$JAVA_HOME/bin/java
$java -jar /jenkins-cli.jar -s http://$JENKINS_PORT_8080_TCP_ADDR:$JENKINS_PORT_8080_TCP_PORT groovy /register-sbt.groovy

/start-java-builder.sh --toolLocation sbt=/usr/local/bin/sbt "$@"

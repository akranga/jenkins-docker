#!/bin/bash

PATH=$JAVA_HOME/bin:$PATH
exec  java $SBT_OPTS -jar /sbt-launch.jar "$@"

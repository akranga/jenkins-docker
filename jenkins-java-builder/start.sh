#!/bin/bash
java=/usr/bin/java
# bootstrap ssh key if not exists
if [ ! -f $USER_HOME/.ssh/id_rsa ]; then
    mkdir -p $USER_HOME/.ssh || true 
    cat /usr/local/etc/insecure_key > $USER_HOME/.ssh/id_rsa
    chmod 600 $USER_HOME/.ssh/id_rsa
fi

# if `docker run` first argument start with `-` the user is passing jenkins swarm launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "-"* ]]; then

  # jenkins swarm slave
  JAR=`ls -1 /usr/share/jenkins/swarm-client-*.jar | tail -n 1`

  # if -master is not provided and using --link jenkins:jenkins
  if [[ "$@" != *"-master "* ]] && [ ! -z "$JENKINS_PORT_8080_TCP_ADDR" ]; then
    PARAMS="-disableSslVerification -master http://$JENKINS_PORT_8080_TCP_ADDR:$JENKINS_PORT_8080_TCP_PORT"
  fi

  echo Running java $JAVA_OPTS -jar $JAR -fsroot $JENKINS_HOME $PARAMS "$@"
  exec $java $JAVA_OPTS -jar $JAR -fsroot $JENKINS_HOME $PARAMS "$@"
fi

# As argument is not jenkins, assume user want to run his own process, for sample a `bash` shell to explore this image
exec "$@"

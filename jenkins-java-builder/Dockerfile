#FROM java:8-jdk
#FROM akranga/dind:1.6.0
FROM ubuntu:trusty
MAINTAINER Antons Kranga <akranga@gmail.com>

ENV JENKINS_VERSION 1.609.3
ENV JENKINS_SWARM_VERSION 2.0
ENV JENKINS_HOME /var/jenkins_home

COPY start.sh /start-java-builder.sh

RUN \
  echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  update-java-alternatives -s java-8-oracle

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

COPY jenkins-cli-1.609.3.jar /jenkins-cli.jar 

WORKDIR /var/jenkins_home
VOLUME  /var/jenkins_home

RUN \
  mkdir -p /usr/share/jenkins \  
  && chmod 755 /usr/share/jenkins \
  && chmod +x /start-java-builder.sh \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JENKINS_SWARM_MIRROR http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar 
ENV JENKINS_SWARM_PATH   /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar

ADD $JENKINS_SWARM_MIRROR $JENKINS_SWARM_PATH

EXPOSE 50000

#USER jenkins

ENTRYPOINT ["/start-java-builder.sh"]

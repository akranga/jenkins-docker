FROM jenkins:1.609.3

USER root

ENV JENKIJNS_WORKFLOW_VERSION 1.10
ENV JENKINS_SWARM_VERSION 2.0
ENV SERVICE_NAME jenkins
ENV SERVICE_TAG www
ENV DOCKER_VERSION latest
ENV JENKINS_VERSION 1.609.2
ENV JENKINS_SECRETS_HOME /etc/secrets/jenkins
ENV JENKINS_HOME /var/jenkins_home

# USER root

COPY plugins.txt /usr/local/etc/plugins.txt
COPY keys/insecure_key /usr/local/etc/insecure_key
COPY start.sh /start.sh

RUN apt-get update && apt-get install curl -yq && \
    curl -o /usr/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION && \
    chmod +x /usr/bin/docker && \
    chmod +x /start.sh && \
    chmod 0644 /usr/local/etc/plugins.txt && \
    sed -e "s|{{workflow_version}}|$JENKIJNS_WORKFLOW_VERSION|" \ 
        -e "s|{{swarm_version}}|$JENKINS_SWARM_VERSION|" \
        -i /usr/local/etc/plugins.txt

# USER jenkins
#ENV JENKINS_UC http://jenkins-updates.cloudbees.com

RUN /usr/local/bin/plugins.sh /usr/local/etc/plugins.txt

# USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY init.groovy.d/* /usr/share/jenkins/ref/init.groovy.d/
VOLUME $JENKINS_SECRETS_HOME

# USER jenkins

#RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

WORKDIR $JENKINS_HOME

ENTRYPOINT ["/bin/tini", "--", "/start.sh"]

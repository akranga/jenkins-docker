#FROM ubuntu:trusty
FROM akranga/jenkins-java-builder
MAINTAINER Antons Kranga <akranga@gmail.com>

# must be the same as docker inside kubernets
ENV DOCKER_VERSION 1.6.0 

COPY ./dmsetup /usr/local/bin/dmsetup
COPY ./wrapdocker /wrapdocker
COPY ./start.sh   /start-docker-builder.sh

RUN apt-get update -qq && apt-get install -qqy \
      supervisor \
      apt-transport-https \
      ca-certificates \
      lxc \
      iptables \
      aufs-tools \
      cgroup-lite

ADD  https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION /usr/bin/docker

RUN chmod +x /usr/bin/docker && \
    chmod +x /wrapdocker && \
    chmod +x /start-docker-builder.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# hack for docker v1.6 as was described:  
#RUN bash -c 'echo " none /cgroup cgroup defaults 0 0" >> /etc/fstab' && \
#    mkdir /cgroup && mount -a && \
#    sysctl -w net.ipv4.ip_forward=1

VOLUME /var/lib/docker

ENTRYPOINT ["/start-docker-builder.sh"]

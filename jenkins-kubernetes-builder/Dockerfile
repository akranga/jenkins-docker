FROM akranga/jenkins-java-builder
MAINTAINER Antons Kranga <akranga@gmail.com>

USER root

ENV KUBEERNETES_VERSION       1.0.6
ENV KUBERNETES_USER           admin
ENV KUBERNETES_SECRETS        /etc/secrets/kube

COPY start-kubernetes-builder.sh /start-kubernetes-builder.sh
ADD https://storage.googleapis.com/kubernetes-release/release/v$KUBEERNETES_VERSION/bin/linux/amd64/kubectl /usr/bin/kubectl

RUN \
  chmod +x /usr/bin/kubectl && \
  chmod +x /start-kubernetes-builder.sh

ENTRYPOINT ["/start-kubernetes-builder.sh"]

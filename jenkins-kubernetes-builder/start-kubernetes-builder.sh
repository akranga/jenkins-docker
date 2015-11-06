#!/bin/bash

kubectl config set-cluster default --certificate-authority=$KUBERNETES_SECRETS/ca.pem --server=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
kubectl config set-credentials cluster-admin --client-key=$KUBERNETES_SECRETS/admin.key

/start-java-builder.sh "$@"

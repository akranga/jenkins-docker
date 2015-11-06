#!/bin/bash -xe

#echo  PARAMS=$(echo "$@")
#echo sed -e "s|{{swarm_params}}|$PARAMS|" -i /etc/supervisor/conf.d/supervisord.conf
if [ "${PRIVATE_REGISTRY_SERVICE_HOST:+1}" ]
then
  TRUSTED_REGISTRIES="$PRIVATE_REGISTRY_SERVICE_HOST:${PRIVATE_REGISTRY_SERVICE_PORT_API:-5000} $TRUSTED_REGISTRIES"
fi

for registry in $TRUSTED_REGISTRIES; do
  DOCKER_DAEMON_ARGS="$DOCKER_DAEMON_ARGS --insecure-registry $registry"
done

export DOCKER_DAEMON_ARGS
export DOCKER_ARGS=$DOCKER_DAEMON_ARGS

echo starting docker daemon with args: $DOCKER_DAEMON_ARGS

(
  /wrapdocker
  exit $?
) &

/start-java-builder.sh "$@"

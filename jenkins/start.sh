#!/bin/bash -xe

# bootstrap ssh key if not exists
if [ ! -f $USER_HOME/.ssh/id_rsa ]; then
    mkdir -p $USER_HOME/.ssh || true 
    cat /usr/local/etc/insecure_key > $USER_HOME/.ssh/id_rsa
    chmod 600 $USER_HOME/.ssh/id_rsa
fi
# strt Jenkins
/usr/local/bin/jenkins.sh

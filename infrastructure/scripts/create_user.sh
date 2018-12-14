#!/bin/bash

umask 077
adduser --quiet --disabled-password --shell /bin/bash --home /home/${1} --gecos '' ${1}
mkdir /home/${1}/.ssh
echo "${2}" > /home/${1}/.ssh/authorized_keys
chown -R ${1}:${1} /home/${1}/.ssh


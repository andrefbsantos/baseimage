#!/bin/bash -ex

source /etc/environment

apt-get install software-properties-common

apt-add-repository ppa:ansible/ansible

apt-get update -qq

apt-get install -y ansible

echo '[local]\nlocalhost\n' > /etc/ansible/hosts

mkdir -p /root/ansible
#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive

apt-get update -qq

apt-get install -y software-properties-common

apt-add-repository -y ppa:ansible/ansible

apt-get update -qq

apt-get install -y ansible

echo '[local]\nlocalhost\n' > /etc/ansible/hosts

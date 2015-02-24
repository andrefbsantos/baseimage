#!/bin/bash -ex

export DEBIAN_FRONTEND=noninteractive

# setup ansible
apt-get update -qq
apt-get install -y --no-install-recommends software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update -qq
apt-get install -y --no-install-recommends ansible git
echo '[local]\nlocalhost ansible_connection=local\n' > /etc/ansible/hosts

# run ansible provision
pushd /tmp
ansible-galaxy install -r requirements.yml
ansible-playbook -i /etc/ansible/hosts playbook.yml --extra-vars "@answer.yml" -vvv
popd

# cleanup
apt-get autoremove -y
apt-get clean -y
rm -rf /var/lib/{apt,cache,log}/ 
rm -fr /tmp/* /var/tmp/*

#!/bin/bash -ex

export DEBIAN_FRONTEND=noninteractive

apt-get update -qq

apt-get install -y software-properties-common

apt-add-repository ppa:ansible/ansible

apt-get update -qq

apt-get install -y ansible git

echo '[local]\nlocalhost ansible_connection=local\n' > /etc/ansible/hosts

pushd /tmp

  mkdir roles && pushd roles
    git clone https://github.com/jacoelho/ansible.box
  popd

  ansible-playbook -i /etc/ansible/hosts playbook.yml
popd


# cleanup
rm -fr roles playbook.yml

apt-get autoremove -y

apt-get clean -y

rm -rf /var/lib/{apt,dpkg,cache,log}/

#!/bin/bash -ex

source /etc/environment

apt-get update
apt-get upgrade

# clean up temporary files
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
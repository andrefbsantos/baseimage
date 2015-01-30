#!/bin/bash -ex

source /etc/environment

# clean up temporary files
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
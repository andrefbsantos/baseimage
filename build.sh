#!/bin/bash

set -e

for SCRIPT in /setup/*; do
  if [ -f $SCRIPT -a -x $SCRIPT ]; then
    $SCRIPT
  fi
done
#!/bin/bash

# start docker daemon
dockerd > /var/log/dockerd.log 2>&1 &
sudo service ssh start

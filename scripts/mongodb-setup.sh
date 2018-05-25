#!/bin/bash

# Installs and configures MongoDB for a node in an AWS EC2 cluster (Ubuntu 16.04)
# Note that these commands are just an aggregation of the install procedure
# found on the MongoDB Community Edition instructions.

# The MongoDB public GPG Key
KEY="2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5"

# Import the public key used by the package management system
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv $KEY

# Create a list file for MongoDB
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

# Reload local package database
sudo apt-get update

# Install the latest stable version of MongoDB
sudo apt-get install -y mongodb-org

################################################################################
# New additions                                                                #
################################################################################

# Add data directions for mongod service
sudo mkdir /data
sudo mkdir /data/db

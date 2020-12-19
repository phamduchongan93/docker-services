#!/bin/bash
# Postinstall for git server 

yum install git openssh -y
useradd -m git 
mkdir -p /home/git/.ssh/
cat /vagrant_data/id_rsa.pub >> /home/git/.ssh/authorized_keys



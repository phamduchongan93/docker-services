# Instruction of installation on Linux Host

## Overview
- This bash script is used to deploy jenkin server on a host via docker method. I also provide a Vagrantfile where you can use to spin up a vm to test out the product. As is right now, the vagrant only work on linux machines where they have kvm built in the kernel.

- There is a ubuntu-playbook.yml file that help the VM to set up the docker engine on VM

## Prerequisites
- 1GB+ of RAM
- 50GB of drive space

## Installation
1. To begin run `main.sh -h ` to quick view the instruction
2. Type `main.sh run` to build the jenkins server on docker  

## Setting up Vagrant Hypervisor

- In Vangrant file, I exposed the port on 192.168.18.2 ip address. Hence, please use this address to test out your services. 

For example:
If I have the jenkin server on port 49000, the socket I will access via web browser is 192.168.18.2:49000



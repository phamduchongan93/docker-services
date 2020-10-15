#!/bin/bash
# Author: An Pham
# Filename: gradle-install.sh 
# Date: Tue Oct 13 04:12:52 EDT 2020
# Description:  Perform gradle installation. This program is used to create CI for main bash deployment script
# 
# Testing file is installgradle.bats

source ../general.sh 

sudoChecker () {
  if  [[ $(id -u) -ne 0 ]]; then
    echo 'error: require root privellege'
    exit 1
  fi 
}


installGradle () { 
  # compatible with centos 
		cd ~/
		wget -O ~/gradle-4.7-bin.zip https://services.gradle.org/distributions/gradle-4.7-bin.zip
		yum -y install unzip java-1.8.0-openjdk
		mkdir /opt/gradle
		unzip -d /opt/gradle/ ~/gradle-4.7-bin.zip
  export PATH=$PATH:/opt/gradle/gradle-4.7/bin
}


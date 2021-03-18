#!/bin/bash
# Author: An Pham
# Filename: Jenkins-blueoccean.sh
# Description: Deploy jenkin docker on raspberry pi4 (arm)
# Version: Stable

#####################################################################################################
# Instruction of jenkins blueoccean installation  is at https://www.jenkins.io/doc/book/installing/ # 
#####################################################################################################

container_name=""
port=""
 
aptInstallDependency () {
  sudo_checker
  apt-get install curl git fidget -y
  echo $? && echo "Done: Packages has been successfully installed" || echo "Error: failure to install some dependency" 
}

yumInstallDependency () {
  sudoCheck
  yum install curl git -y
}


intro () {
  figlet "Jenkins Blueoccean" 
}

destroyContainer () {
  local containerName="${1}"
  docker rm -f "${containerName}"
}

createVolume () {
  docker volume create jenkins_home
}



checkContainer () {
  local container_name="${1}"
  docker ps | grep -i "$container_name"; ec="$?"
  [ $ec -eq 0 ] && exit 0
  destroyContainer "$container_name"
}

createJenkinsDocker () {
  checkContainer 'jenkins-server' 
  destroyContainer 'jenkins-server'
  docker pull mlucken/jenkins-arm
  docker container run -d \
  --name jenkins-server \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  mlucken/jenkins-arm
}

echoPass () {
  local containerName="${1}"

  command=$(eval 'docker exec -t "$containerName" /bin/cat /var/jenkins_home/secrets/initialAdminPassword')
  printf "Your initial Jenkins password is: $command \nPlease copy this pass to your jenkins server! \n " 
}


output () {
  local container_name="${1}"
  local port="${2}"
  local hostIP=$(eval "hostname -I | cut -d ' ' -f1")
  clear;
  echo "Container has been successfully deployed"
  echo " ${container_name} is running on ${hostIP}:${port}"
  echo " "
}

run_main () {                   
  createVolume
  createJenkinsDocker 
  output jenkins-server 8080
  echoPass jenkins-server
}

## Help module #
help () {
  echo "Usuage: $(basename $0) <-r|-d>  "
  echo ''
  echo 'Where:'
  echo '  -h,--help        show the help page'
  echo '  -r,run           launch program in interactive mode ' 
  echo '  -d,destroy       destroy container'
  echo ''
  echo 'Example:'
  echo "  $(basename $0) -d   destroy the container  "
}       




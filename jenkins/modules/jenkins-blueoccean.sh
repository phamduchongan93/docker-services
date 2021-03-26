#!/bin/bash
# Author: An Pham
# Filename: Jenkins-blueoccean.sh
# Description: Modules and submodules used to deploy jenkins blueoccean. 
# Keep in mind that the blueoocean will use two container. One contains the docker engine and other contains the blueoccean container.

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

destroyAll () {
  # wipe out the old jenkins docker contianer 
  docker container stop jenkins-docker 
  docker container stop jenkins-blueocean 
  docker network remove jenkins 
  docker volume rm jenkins-docker-certs 
  docker volume rm jenkins-data 
  docker rm -f jenkins-docker
  docker rm -f jenkins-blueocean
}

createNetwork() {
 #create network jenkins
 docker network ls | grep jenkins > /dev/null; local ec="$?" 
 [ $ec -eq 1 ] &&  docker network create jenkins 
}

createVolume () {
  # create volumes to share TLS certificates
  docker volume create jenkins-docker-certs
  docker volume create jenkins-data
}

checkContainer () {
  local container_name="${1}"
  docker ps | grep -i "$container_name"; ec="$?"
  [ $ec -eq 0 ] && exit 0
}

createNestedDocker () {
 checkContainer 'jenkins-docker' 
 docker container run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs  \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind 
}

createJenkinsBlueoccean () {
  checkContainer 'jenkins-blueocean'
  docker container run \
      --name jenkins-blueocean \
      --rm \
      --detach \
       --network jenkins \
       --env DOCKER_HOST=tcp://docker:2376 \
       --env DOCKER_CERT_PATH=/certs/client \
       --env DOCKER_TLS_VERIFY=1 \
       --publish 49000:8080 \
       --publish 50000:50000 \
       --volume jenkins-data:/var/jenkins_home \
       --volume jenkins-docker-certs:/certs/client:ro \
       jenkinsci/blueocean
}

output () {
  container_name="${1}"
  port="${2}"
  echo " Container has been successfully deployed"
  echo " ${container_name} is running on port ${port}"
  echo " "
}

run_main () {                   
  destroyAll
  createNetwork                
  createVolume
  createNestedDocker
  createJenkinsBlueoccean
  output Jenkins-blueocean 49000
}

## Help module #
help () {
  echo "Usuage: $(basename $0) <-i|-d>  "
  echo ''
  echo 'Where:'
  echo '  -h,--help          show the help page'
  echo '  -s,--status        display the status of jenkins'
  echo '  -b,--build         launch program in interactive mode ' 
  echo '  -d,--destroy       destroy container'
  echo '__________________________________________________________________'
  echo 'Example:'
  echo "  $(basename $0) -h         show the help page"
  echo "  $(basename $0) -s         display status of the jenkins"
  echo "  $(basename $0) -b         build the program in interactive mode "
  echo "  $(basename $0) -d         destroy the container  "
  echo '__________________________________________________________________'
}       




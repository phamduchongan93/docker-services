#!/bin/bash
# Author: An Pham
# Description: Deploy jenkins blueoccean 
# Version: Testing

#####################################################################################################
# Instruction of jenkins blueoccean installation  is at https://www.jenkins.io/doc/book/installing/ # 
#####################################################################################################

### Modules and variable declare ###

container_name = ""
port = ""

aptInstallDependency () {
  sudo_checker()
  apt-get install curl git -y
  echo !? && echo "Done: Packages has been successfully installed" || echo "Error: failure to install some dependency"

}

yumInstallDependency () {
  sudo_checker()
  yum install curl git -y
}

createNetwork() {
  docker network create jenkins 
}


createVolume () {
  # create volumes to share TLS certificates
  docker volume create jenkins-docker-certs
  docker volume create jenkins-data
}

createNestedDocker () {
 docker container run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind 
}

createJenkinsBlueoccean () {
		docker container run \
				--name jenkins-blueocean \
				--rm \
				--detach \
				--network jenkins \
				--env DOCKER_HOST=tcp://docker:2376 \
				--env DOCKER_CERT_PATH=/certs/client \
				--env DOCKER_TLS_VERIFY=1 \
				--publish 8080:8080 \
				--publish 50000:50000 \
				--volume jenkins-data:/var/jenkins_home \
				--volume jenkins-docker-certs:/certs/client:ro \
				jenkinsci/blueocean
}

input () {
} 

output () {
  container_name = "${1}"
  port = "${2}"

  echo " Container has been successfully deployed"
  echo " ${container_name} is running on port ${port}"
  echo " "
}

### Main Program ###

installDependency()

input 

output "$container_name" "$port"

### End main ### 
help () {
  echo "Usuage: $(basename $0) <-i|-d>  "
  echo ''
  echo 'Where:'
  echo '  -h,--help          show the help page'
  echo '  -i,--interactive   launch programin in interactive mode ' 
  echo '  -d,--destroy       destroy container'
  echo ''
  echo 'Example:'
  echo "  $(basename $0) -l   list current running system"
  echo "  $(basename $0) -d   destroy the container  "
}       



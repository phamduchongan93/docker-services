#!/bin/bash
# Program: building nextcloud container
# Author: An Pham
# Date: Tue Oct  6 19:18:49 EDT 2020
# Description:  deploy next cloud service 

nextcloudDocker ()  {
		service_port="${1}"
		volume_path="${2}"
  container_name="${3}"
		echo "Starting to build nextcloud container"  
		docker run -d -p "$service_port":80 -v nextcloud:"${volume_path}" nextcloud && ec="!?"
  [ $ec = 0 ] &&  echo "Program has been succesfully built" || echo " Program has been failed to initiate"
}

nextcloudCompose () {
  
}

nextcloudDockerfile () {
  {
   echo "cloud9_autorun=true"
   echo
   echo "if [ \"\$cloud9_autorun\" = true ]; then"
   echo "  treehouses services cloud9 up"
   echo "fi"
   echo
   echo
  } > Dockerfile
}


fasdf

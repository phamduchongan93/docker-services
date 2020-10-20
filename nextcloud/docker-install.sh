#!/bin/bash
# Program: building nextcloud container
# Author: An Pham
# Date: Tue Oct  6 19:18:49 EDT 2020
# Description:  deploy next cloud service 

nextcloudDocker ()  {
		local service_port="${1}"
		local volume_path="${2}"
  local container_name="${3}"
		echo "Starting to build nextcloud container"  
		docker run --name nextcloud_disk -d -p "$service_port":80 -v nextcloud:"${volume_path}" nextcloud && ec="$?"
  [[ "$ec" -eq 0 ]] &&  echo "Program has been succesfully built" || echo " Program has been failed to initiate"
}

nextcloudCompose () {
 pass  
}

nextcloudDockerfile () {
  {
   pass
   echo "cloud9_autorun=true"
   echo
   echo "if [ \"\$cloud9_autorun\" = true ]; then"
   echo "  treehouses services cloud9 up"
   echo "fi"
   echo
   echo
  } > Dockerfile
}

nextcloudDestroy () {
  docker rm -f nextcloud_disk 
}

run_main () {
 # nextcloudDocker 90 "$(pwd)"
  nextcloudDestroy 
}

## 
case "$" in
  build 
    run_main ${1} ${2}  
  *) 
    echo "Error: Invalid Input"
esac

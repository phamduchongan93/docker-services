#!/bin/bash
# Date: Oct 4, 2020 
# Author: An Pham
# Description: Program that helps to spin up calibre book docker container. To begin with interactive mode,type `calibre -i ` 
# Version: Testing
# 

### Modules and variable declare ###
container_name=""
port=""
path_to_config=""
path_to_calibre_library=""


aptInstallDependency () {
  sudo_checker
  apt-get install git curl -y
		pass 
}

yumInstallDependency () {
		pass
}

input () {
		echo "Please type in container_name: "
		read container_name

  echo "Please type in the location you want to share your books: "
  read path_to_calibre_library # global variable 

  echo "Please type in location of your config: "
  read path_to_config          # global variable

		echo "Please type in port of your application: "
		read port

} 

calibreDocker () {
  local container_name=$1 
  local port=$2
  local books=$3

  # build container  of calibre web
  docker run -d \
     --name=calibre-web \
     -e PUID=1000 \
     -e PGID=1000 \
     -e TZ=Europe/London \
     -e DOCKER_MODS=linuxserver/calibre-web:calibre \
     -p "$port:8083" \
     -v '/home/anpham/Calibre Library':/config \
     -v '/home/anpham/Calibre Library':/books \
     --restart unless-stopped \
     linuxserver/calibre-web
}

output () {
  container_name="${1}"
  port="${2}"

  echo " Container has been successfully deployed"
  echo " ${container_name} is running on port ${port}"
  echo " "
}


### Main Program ###

# calibreDocker "$container_name" "$port" "$path_to_config" "$path_to_calibre_library"
calibreDocker "calibre-web" "8083" ""
docker ps;
#output "$container_name" "$port" "$path_to_calibre_library"

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


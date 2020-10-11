#!/bin/bash
# Date: Oct 4, 2020 
# Author: An Pham
# Description: Program that helps to spin up calibre book docker container. To begin with interactive mode,type `calibre -i ` 
# Version: Testing


### Modules and variable declare ###
container_name = ""
port = ""
path_to_config = ""
path_to_calibre_library = ""


aptInstallDependency () {
  sudo_checker()
  apt-get install   
}

yumInstallDependency () {
}

input () {
  echo "Please type in the location you want to share your books: "
  read path_to_calibre_library # global variable 

  echo "Please type in location of your config: "
  read path_to_config          # global variable
} 

calibreDocker () {
  local container_name = $1 
  local port = $2
  local config = $3 
  local books = $4

  # build container  of calibre web
  docker create \
     --name=calibre-web \
     -e PUID=1000 \
     -e PGID=1000 \
     -e TZ=Europe/London \
     -e DOCKER_MODS=linuxserver/calibre-web:calibre \
     -p 8083:8083 \
     -v $path_to_config:/config \
     -v $path_to_calibre_library:/books \
     --restart unless-stopped \
     linuxserver/calibre-web
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

input $path_to_config $path_to_calibre_library 
calibreDocker() 

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


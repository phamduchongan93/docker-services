#!/bin/bash
# Date: Oct 4, 2020 
# Author: An Pham
# Description: Program that helps to spin up calibre book docker container. To begin with interactive mode,type `calibre -i ` 
# Version: Testing

ARGS=($"@")
### Modules and variable declare ###
container_name=""
port=""
path_to_config=""
path_to_calibre_library=""


aptInstallDependency () {
		# install extra pacakge in case needed
  sudo_checker
  apt-get install git curl -y
		pass 
}

yumInstallDependency () {
		# installing extra packages in case needed.
		pass
}

input () {
  figlet 'Calibre Web'
		printf "Please type in container_name: "
		read container_name

  printf "Please type in the location you want to share your books: "
  read path_to_calibre_library # global variable 

  # printf "Please type in location of your config: "
  # read path_to_config          # global variable

		printf "Please type in port of your application: "
		read port
} 

checkContainer () {
# check if the container exist and running, and prompt user whether they want to remove the container
  local container_name="$1"

  docker ps -a | grep "^${container_name}$"; ec="$?";
		if [[ "$ec" -eq 0 ]]; then
				printf "The container $1 is running. Do you want to remove it? "
				read answer
				case "$answer" in
						y|Y)
						  docker rm -f "${container_name}"
						  echo "Succefully remove the container ${container_name}!"
							 read -p 'Please any key to continue'	
								;;
						n|N)
        exit 0
						  ;; 
						*)
						  printf "Error: Invalid selection" 
								exit 1
								;;
    esac
		fi 
}

checkPort () {
		local port_number="$1"
  docker ps -a | grep ":$port_number" ; ec="$?"

 	if	[[ "$ec" -eq  0 ]]; then
				echo "Port $port_number has been used. "
				read -P "Press any key to continue" 
  fi	
}

buildCalibreDocker () {
  local container_name=$1 
		checkContainer "$container_name"
		
  local port=$2
		checkPort "$port"

  local books=$3

  # build container  of calibre web
  docker run -d \
     --name="$container_name" \
     -e PUID=1000 \
     -e PGID=1000 \
     -e TZ=Europe/London \
     -e DOCKER_MODS=linuxserver/calibre-web:calibre \
     -p "$port:8083" \
     -v "$books":/config \
     -v "$books":/books \
     --restart unless-stopped \
					 ghcr.io/linuxserver/calibre-web
}

destroyCalibreDocker () {
  pass
}

output () {
  container_name="${1}"
  port="${2}"

  echo " Container has been successfully deployed"
  echo " ${container_name} is running on port ${port}"
  echo " Default login: admin"
  echo " Default pass: admin123"
		  
}


### Main Program ###
"$@"

# calibreDocker "$container_name" "$port" "$books"
input
checkContainer
calibreDocker "$container_name" "$port" "$path_to_calibre_library";
docker ps;
output "$container_name" "$port";

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


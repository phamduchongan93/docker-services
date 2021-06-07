#!/bin/bash
# Name: Build and create kanboard
# Variable Declare # 

containerName=""
portNumber=""

input () {
		printf "Name the container: "
  read containerName
		printf "Assign the port for container: "
  read portNumber
}

# Function Declare # 

intro () {
#		cat <<EOF 
echo kanboard
#			_               _                         _ 
#		| | ____ _ _ __ | |__   ___   __ _ _ __ __| |
#		| |/ / _` | '_ \| '_ \ / _ \ / _` | '__/ _` |
#		|   < (_| | | | | |_) | (_) | (_| | | | (_| |
#		|_|\_\__,_|_| |_|_.__/ \___/ \__,_|_|  \__,_|
#		EOF 
}


destroyAll () {
  local containerName="$1"

  docker container stop "$containerName" 
  docker rm -f "$containerName"
}

checkContainer () {
		local containerName="$1"
		local portNumber="$2"

  docker ps | grep "$containerName"; ec="$?"
		
  if [ $ec -eq 0 ]; then
		  printf "Container exist, do you want to destroy it" 
				case $answer in 
						y|Y)
								docker rm -f "$containerName"
								;;
						n|N)
							 exit 0	
								;;
					 *)
								printf "Error: Invalid selection"
								;;
				esac 
		fi 	

  docker ps | grep ":$portNumber"; ec="$?";
		if [ $ec -eq 0 ]; then
    printf "Port $portNumber has been used by other services, please select another port! \n "
				exit 1
		fi
}

buildKanboard () {
  local containerName="$1"
		local portNumber="$2"
		# checking if the container is running  

		checkContainer "$containerName" "$portNumber"
		printf "Starting to build container ...\n"
  docker run -d --restart unless-stopped --name "$containerName"  -p "$portNumber:80" -t kanboard/kanboard:v1.2.8
}

buildKanboardDC () {
		# use docker-compose to launch the services
		mkdir -P ./var/www/app/data # Application data (sqlite database, attachments, etc.)
		mkdir -P ./var/www/plugins # Plugins
		mkdir -P ./etc/nginx/ssl # SSL certifcates 

		cat << EOF > docker-compose.yml
version: '2'
  services:
  kanboard:
  image: kanboard/kanboard:latest
    ports:
      - "\${portNumber}:80"
      - "443:443"
    volumes:
      - kanboard_data:/var/www/app/data
      - kanboard_plugins:/var/www/app/plugins
      - kanboard_ssl:/etc/nginx/ssl
		volumes:
				kanboard_data:
				kanboard_plugins:
				kanboard_ssl:
EOF
}


output () {
  docker ps 
} 

runMain () {
  input 
		checkContainer "$containerName" "$portNumber"
		buildKanboard "$containerName" "$portNumber"
		output 
} 

help () {
  echo "Usuage: $(basename $0) <-h|-r|-l|-d> "
  echo ''
		echo 'Where:'
		echo '  -h,--help    show the help page'
		echo '  -r,--run     spin up the docker container  '
		echo '  -l,--list    view current running docker'
		echo '  -d,--destroy destroy docker container'
}


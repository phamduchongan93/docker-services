#!/bin/bash

# Variable Declare # 
input () {
		printf "Name the container: "
  read containerName
		printf "Assign the port for container: "
  read portNumber
}
# Function Declare # 

intro () {
		cat <<EOF 
			_               _                         _ 
		| | ____ _ _ __ | |__   ___   __ _ _ __ __| |
		| |/ / _` | '_ \| '_ \ / _ \ / _` | '__/ _` |
		|   < (_| | | | | |_) | (_) | (_| | | | (_| |
		|_|\_\__,_|_| |_|_.__/ \___/ \__,_|_|  \__,_|
		EOF 
}

checkContainer 

destroyAll () {
  local containerName="$1"

  docker container stop "$containerName" 
  docker rm -f "$containerName"
}

buildKanboard () {
  local containerName="$1"
		local portNumber="$2"
		# checking if the container is running  

		checkContainer "$containerName"
		printf "Starting to build container ...\n"
  docker run -d --name "$containerName"  -p "$portNumber:80" -t kanboard/kanboard:v1.2.8
}

destroyAll () {
  pass 
}

output () {
  pass  
} 

runMain () {
  input $containerName $portNumber
		checkContainer $containerName
		buildKanboard $containerName $portNumber
		output 
} 

#!/bin/bash

# Variable Declare # 
containerName=""
portNumber=""

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
	
}

output () {
  pass  
} 

runMain () {
		checkContainer $containerName
  input $containerName $portNumber
		buildKanboard $containerName $portNumber
		output 
} 


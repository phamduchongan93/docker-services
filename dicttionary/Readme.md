#!/bin/bash
# Filename: main.sh
# Description: use to build and deploy jenkins occeans.
#

# Instruction
- `docker exec -it stardiction startdict sdcv <words>`
- to download the image 
  `docker pull startdict`

# Build local images 

- `docker build -t <docker_name> .`
- `docker build -t startdict-doc:testing .`

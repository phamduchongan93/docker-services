#!/bin/bash

source modules/installKanboard.sh

while [ "$#" -gt 0 ]
do
  case "$1" in 
    -r | run)
      intro
      runMain 
      ;;
    -d | destroy)
      shift
      destroyAll "$1"
      ;;
    -t | test) 
      ;;
    *)
      echo "Error: Invalid option"
      help
      exit 1
      ;;
  esac 
  shift
done

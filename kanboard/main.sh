#!/bin/bash

source modules/installKanboard.sh

while [ "$#" -gt 0 ]
do
  case "$1" in 
    run)
      intro
      runMain 
      ;;
    destroy)
      destroyAll
      ;;
    test) 
      ;;
    *)
      echo "Error: Invalid option"
      help
      exit 1
      ;;
  esac 
  shift
done

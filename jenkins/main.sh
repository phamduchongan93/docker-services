#!/bin/bash 
#  Running Jenkins deplyment

Source ./modules/jenkins-blueoccean.sh

while [ -n "$1" ]
do
		case $1 in 
				run)
						intro
						run_main
						;;
				destroy)
						destroyAll
						;;
				test) 
						bats jenkins-blueoccean.bats;
						;;
				* | -*)
						echo "Error: Invalid option"
						help
						exit 1
						;;
		esac 
		shift
done

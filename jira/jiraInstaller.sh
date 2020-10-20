#!/bin/bash
# Author: An Pham
# Description: Used to deploy jira servicers
# Filename: jiraInstaller.sh 
# Testing: jiraInstaller.bats

## Variable ##
POSTGRES_PASSWORD=mysecretpassword
POSTGRES_USER=jira
POSTGRES_DB=jira

preBuild () {
  # creat interfaces and volume
  docker network create jira-net
  docker volume create jira_data
  docker volume create jira_pg
}

startPostgresql () {
		docker run --name jira_pg \
  		--network jira-net \
	  	-e POSTGRES_PASSWORD=mysecretpassword \
		  -e POSTGRES_USER=jira \
		  -e POSTGRES_DB=jira  \
		  -v jira_pg:/var/lib/postgresql/data \
		  -d postgres
}

startJira () {
  docker run --name jira -it  \
    --network jira-net \
    -v jira_data:/var/atlassian/application-data/jira \   
    -p 8443:8443 \
    hakunacloud/jira
}

run_main () {
  createENV
  startPostgresql
  startJira 
}


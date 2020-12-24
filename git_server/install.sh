#!/bin/bash
# Postinstall for git server 
preInstall () {  
		yum install git openssh -y
		useradd -m git 
		groupadd git
		su - git
		useradd -r -m -U -d /home/git -s /bin/bash git
  mkdir -p /home/git/.ssh/ && chown git:git /home/git/.ssh && chmod 0700 /home/git/.ssh
}

preInstall 
repoName="${1// /_}" # input parsing
cat /vagrant_data/id_rsa.pub >> /home/git/.ssh/authorized_keys
printf "Creating the $repoName repository ... " 
git init --bare "/home/git/$repoName.git"



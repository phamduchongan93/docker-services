#!/bin/bash
# Postinstall for git server 

preInstall () {  
		yum install git openssh sftp-server  -y
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
printf "Creating backup for $repoName\n"
tar -cvzf "/home/git/$repoName.tgz" "/home/git/$repoName"
printf "You git repo backup will be save on data folder of localhost and vagrant_data on VM "
mv -v "/home/git/$repoName.tgz" "/vagrant_data"



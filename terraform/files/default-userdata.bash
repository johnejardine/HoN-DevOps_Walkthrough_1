#!/bin/bash
# Default Bootstrap script

yum -y install epel-release
yum makecache
yum -y update
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker
sudo usermod -aG docker centos
sleep 3
docker pull jenkins/jenkins
cd /home/centos
cat >| Dockerfile << DOCKERFILE
FROM jenkins/jenkins:lts
USER root
RUN apt update
RUN apt-get -y install build-essential
USER jenkins
DOCKERFILE
docker build -t herdofneurons/devops_walkthrough_1 .
docker run -p 8080:8080 herdofneurons/devops_walkthrough_1
# Set command line interface to something I'm used to....
cat >| /etc/profile.d/tuneenv.sh << TUNED
alias dir="ls -Altr"
set -o vi
TUNED

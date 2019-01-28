#!/bin/bash
set -x

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo

yum -y install docker-ce-17.12.1.ce-1.el7.centos
systemctl enable docker
systemctl start docker

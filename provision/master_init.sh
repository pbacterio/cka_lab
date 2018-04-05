#!/bin/bash
set -x

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.33.20

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/IshwarKanse/cka_lab/master/kube-flannel.yml
echo 'source <(kubectl completion bash)' >> $HOME/.bashrc

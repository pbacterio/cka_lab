#!/bin/bash
set -x

NODE_IP=$(ip -br -4 address show eth1 | awk '{split($3,ip,"/"); print ip[1]}')
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$NODE_IP

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f /vagrant/provision/kube-flannel.yml
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
echo 'source <(kubectl completion bash)' >> $HOME/.bashrc

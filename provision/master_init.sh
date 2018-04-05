#!/bin/bash
set -x

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.33.20

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

FLANNEL_VERSION=v0.9.1
curl -o /tmp/kube-flannel.yml https://raw.githubusercontent.com/coreos/flannel/$FLANNEL_VERSION/Documentation/kube-flannel.yml
sed -i.bak 's|"/opt/bin/flanneld",|"/opt/bin/flanneld", "--iface=eth1",|' /tmp/kube-flannel.yml
kubectl apply -f /tmp/kube-flannel.yml
echo 'source <(kubectl completion bash)' >> $HOME/.bashrc

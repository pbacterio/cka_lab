#!/bin/bash
set -x

apt-get update
apt-get -y install docker.io curl gnupg

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm=1.19.4-00 kubectl=1.19.4-00
apt-mark hold kubelet kubeadm kubectl

swapoff -a
sed -i '/swap/d' /etc/fstab

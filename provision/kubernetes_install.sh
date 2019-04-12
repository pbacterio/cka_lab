#!/bin/bash
set -x

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

swapoff -a
sed -i '/swap/d' /etc/fstab
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet-1.13.2
yum install -y kubeadm-1.13.2 ipvsadm

modprobe ip_vs
modprobe ip_vs_rr
modprobe ip_vs_sh
modprobe ip_vs_wrr

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

NODE_IP=$(ip -br -4 address show eth1 | awk '{split($3,ip,"/"); print ip[1]}')
cat << EOF > /etc/systemd/system/kubelet.service.d/50-customs.conf
[Service]
Environment="KUBELET_CGROUP_ARGS=--cgroup-driver=cgroupfs"
Environment="KUBELET_EXTRA_ARGS=--node-ip=${NODE_IP}"
EOF

systemctl enable kubelet
systemctl start kubelet

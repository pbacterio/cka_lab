#!/bin/bash
set -x

vagrant up

#Fix Kubelet IP on Master
vagrant ssh master -c "echo 'Environment=\"KUBELET_EXTRA_ARGS=--node-ip=192.168.33.20\"' | sudo tee --append  /etc/systemd/system/kubelet.service.d/10-kubeadm.conf"
vagrant ssh master -c "sudo systemctl daemon-reload"
vagrant ssh master -c "sudo systemctl restart kubelet.service"

#Fix Kubelet IP on Node1
vagrant ssh node1 -c "echo 'Environment=\"KUBELET_EXTRA_ARGS=--node-ip=192.168.33.21\"' | sudo tee --append  /etc/systemd/system/kubelet.service.d/10-kubeadm.conf"
vagrant ssh node1 -c "sudo systemctl daemon-reload"
vagrant ssh node1 -c "sudo systemctl restart kubelet.service"

#Fix Kubelet IP on Node2
vagrant ssh node2 -c "echo 'Environment=\"KUBELET_EXTRA_ARGS=--node-ip=192.168.33.22\"' | sudo tee --append  /etc/systemd/system/kubelet.service.d/10-kubeadm.conf"
vagrant ssh node2 -c "sudo systemctl daemon-reload"
vagrant ssh node2 -c "sudo systemctl restart kubelet.service"

join_cmd=$(vagrant ssh master -c "sudo kubeadm token create --print-join-command")

vagrant ssh node1 -c "sudo ${join_cmd}"
vagrant ssh node2 -c "sudo ${join_cmd}"

#!/bin/bash
set -x

vagrant up

cluster_token=$(vagrant ssh master -c 'kubeadm token create 2>/dev/null')
join_cmd="sudo kubeadm join 192.168.88.20:6443 --token ${cluster_token:0:-1} --discovery-token-unsafe-skip-ca-verification"

vagrant ssh node1 -c "$join_cmd"
vagrant ssh node2 -c "$join_cmd"

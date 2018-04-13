#!/bin/bash
apt update && apt upgrade -y && apt install nfs-kernel-server -y
mkdir /var/nfs/general -p
chown nobody:nogroup /var/nfs/general
echo '/var/nfs/general      192.168.33.20(rw,sync,no_subtree_check) 192.168.33.21(rw,sync,no_subtree_check) 192.168.33.22(rw,sync,no_subtree_check)' >> /etc/exports
systemctl restart nfs-kernel-server

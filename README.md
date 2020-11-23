CKA Lab
=======

Laboratory environment for "Certified Kubernetes Administrator (CKA)" Linux Academy course

kubernetes v1.13 (to use a different version look at https://github.com/pbacterio/cka_lab/tags)

Build cluster
-------------

Execute: `./build_cluster.sh`

This script creates three virtual machines:

  | name   | IP            |
  | ------ | ------------- |
  | master | 192.168.88.20 |
  | node1  | 192.168.88.21 |
  | node2  | 192.168.88.22 |


To access this machines just use `vagrant ssh <machine>`, for example:

  `vagrant ssh master` or `vagrant ssh node1`


Access Kubernetes
-----------------

The vagrant user on master node has admin credential for kubernetes.
So you can use kubectl on a easy way.

Example:

```
[pbacterio@localhost cka_lab]$ vagrant ssh master
Last login: Mon Jan 28 09:24:31 2019 from 192.168.121.1
[vagrant@master ~]$ kubectl get nodes
NAME     STATUS   ROLES    AGE     VERSION
master   Ready    master   2m57s   v1.13.2
node1    Ready    <none>   2m15s   v1.13.2
node2    Ready    <none>   2m12s   v1.13.2
```


Shutdown
--------

To stop all the machines execute: `vagrant halt`


Boot up
-------

To boot up the cluster use: `vagrant up`


Destroy
-------

If you want to destroy the cluster to build it again or just to free resources,
use: `vagrant destroy`

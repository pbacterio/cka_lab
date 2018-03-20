CKA Lab
=======

Laboratory environment for "Certified Kubernetes Administrator (CKA)" Linux Academy course


Build cluster
-------------

Execute: `./build_cluster.sh` 

This script creates three virtual machines:

  | name   | IP            |
  | ------ | ------------- |
  | master | 192.168.33.20 |
  | node1  | 192.168.33.21 |
  | node2  | 192.168.33.22 |


To access this machines just use `vagrant ssh <machine>`, for example:

  `vagrant ssh master` or `vagrant ssh node1`


Access Kubernetes
-----------------

The vagrant user on master node has admin credential for kubernetes.
So you can use kubectl on a easy way.

Example:

```
[pbacterio@localhost cka_lab]$ vagrant ssh master
Last login: Tue Mar 20 12:56:07 2018 from 192.168.121.1
[vagrant@master ~]$ kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
master    Ready     master    6d        v1.9.4
node1     Ready     <none>    6d        v1.9.4
node2     Ready     <none>    6d        v1.9.4
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

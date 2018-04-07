# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder './', '/vagrant', disabled: true
  config.vm.provision "shell", path: "provision/docker_install.sh"
  config.vm.provision "shell", path: "provision/kubernetes_install.sh"


  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.33.20"
    master.vm.provision "shell", path: "provision/master_init.sh", privileged: false
    for p in [:virtualbox, :libvirt] do
      master.vm.provider p do |provider|
        provider.memory = 2048
        provider.cpus = 2
      end
    end
  end

  config.vm.define "node1" do |node1|
    node1.vm.hostname = "node1"
    node1.vm.network "private_network", ip: "192.168.33.21"
    for p in [:virtualbox, :libvirt] do
      node1.vm.provider p do |provider|
        provider.memory = 2048
        provider.cpus = 2
      end
    end
  end

  config.vm.define "node2" do |node2|
    node2.vm.hostname = "node2"
    node2.vm.network "private_network", ip: "192.168.33.22"
    for p in [:virtualbox, :libvirt] do
      node2.vm.provider p do |provider|
        provider.memory = 2048
        provider.cpus = 2
      end
    end
  end

end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "raring"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box" 
  config.vm.provision :shell, :path => "script/provision-development"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024", "--ioapic", "on"]
  end

  # Because Virtualbox's shared filesystem is extremely slow
  config.vm.synced_folder ".", "/vagrant", nfs: true
  # NFS requires this
  config.vm.network "private_network", ip: "192.168.50.4"

  config.vm.network "forwarded_port", guest: 3000, host: 3005

  config.vm.provider "vmware_fusion" do |vm, config|
    config.vm.box = "saucy64"
    vm.vmx['memsize'] = 1024
  end
end

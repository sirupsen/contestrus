# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "saucy64"

  # Because Virtualbox's shared filesystem is extremely slow
  config.vm.synced_folder ".", "/vagrant", nfs: true
  config.vm.network :forwarded_port, guest: 3000, host: 3005

  config.ssh.forward_agent = true

  config.vm.provider "vmware_fusion" do |vmware, override|
    override.vm.box_url = "http://shopify-vagrant.s3.amazonaws.com/ubuntu-13.10_vmware.box" 
    vmware.vmx['memsize'] = 1024
  end

  config.vm.provider "virtualbox" do |virtualbox, override|
    override.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"
    virtualbox.customize ["modifyvm", :id, "--memory", "1024", "--ioapic", "on"]
  end

  config.vm.provision :shell, :path => "script/provision-development"
end

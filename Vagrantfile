# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "jdowning/trusty64"

  # Because Virtualbox's shared filesystem is extremely slow
  config.vm.synced_folder ".", "/vagrant", nfs: true
  config.vm.network :forwarded_port, guest: 3000, host: 3005

  config.ssh.forward_agent = true

  config.vm.provider "vmware_fusion" do |vmware, override|
    vmware.vmx['memsize'] = 1024
  end

  config.vm.provision :shell, :path => "script/provision-development"
end

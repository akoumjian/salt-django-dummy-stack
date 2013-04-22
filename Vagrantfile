# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"

  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.synced_folder ".", "/srv"

  config.vm.provision :salt do |salt|
  end
end

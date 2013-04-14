# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Box: Ubuntu Raring Ringtail (13.04)
  config.vm.box = "raring64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

  # Network Setup
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.network :forwarded_port, guest: 3306, host: 3306

  # VM Configuration
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.name = "Development"
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--acpi", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Initialization Provisioning
  config.vm.provision :shell, :path => ".chef/initialization.sh"

  # Main Provisioning
  config.vm.provision :chef_solo do |chef|

    # Configuration
    chef.cookbooks_path = [".chef/cookbook/generic/", ".chef/cookbook/specific/"]
    chef.data_bags_path = ".chef/databag/"
    chef.roles_path = ".chef/role/"

    # Roles
    chef.add_role("base")
    chef.add_role("web")
    chef.add_role("email")
    chef.add_role("database")
  end
end

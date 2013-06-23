# -*- mode: ruby -*-
# vi: set ft=ruby :

# YAML
require "yaml"

# Settings
settings = YAML.load_file("settings.yaml")

# Vagrant Configuration
Vagrant.configure("2") do |config|

  # Base Box
  if settings["guest"]["architecture"] == "64-bit"
    config.vm.box = "raring64"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"
  else
    config.vm.box = "raring32"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"
  end

  # Network Setup
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.network :forwarded_port, guest: 3306, host: 3306

  # Synced Folders
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "host", "/var/www"
  config.vm.synced_folder "log", "/var/log/apache2"

  # VM Configuration
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.name = settings["guest"]["name"]
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    vb.customize ["modifyvm", :id, "--memory", settings["guest"]["memory"].to_i]
    vb.customize ["modifyvm", :id, "--cpus", settings["guest"]["cpus"].to_i]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    vb.customize ["modifyvm", :id, "--acpi", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
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

# -*- mode: ruby -*-
# vi: set ft=ruby :

# YAML
require "yaml"

# Settings
if File.exists?("settings.yaml")
  settings = YAML.load_file("settings.yaml")
else
  abort("No settings.yaml file found.")
end

# Vagrant Configuration
Vagrant.configure("2") do |config|

  # Base Box
  if settings["guest"]["architecture"] == "64-bit"
    config.vm.box = "raring64"
  else
    config.vm.box = "raring32"
  end

  # Network Setup
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.network :forwarded_port, guest: 3306, host: 3306

  # Synced Folders
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "host", "/var/www", :nfs => true
  config.vm.synced_folder "log", "/var/log/apache2", :nfs => true

  # VirtualBox Configuration
  config.vm.provider :virtualbox do |provider, config|
    provider.gui = false
    provider.name = settings["guest"]["name"]
    provider.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    provider.customize ["modifyvm", :id, "--memory", settings["guest"]["memory"].to_i]
    provider.customize ["modifyvm", :id, "--acpi", "on"]
    provider.customize ["modifyvm", :id, "--ioapic", "on"]
    provider.customize ["modifyvm", :id, "--cpus", settings["guest"]["cpus"].to_i]
    provider.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    provider.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    provider.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # VMware Workstation Configuration
  config.vm.provider :vmware_workstation do |provider, config|
    provider.gui = false
    provider.vmx["displayName"] = settings["guest"]["name"]
    provider.vmx["guestOS"] = "ubuntu-64"
    provider.vmx["numvcpus"] = settings["guest"]["cpus"].to_i
    provider.vmx["memsize"] = settings["guest"]["memory"].to_i
  end

  # VMware Fusion Configuration
  config.vm.provider :vmware_fusion do |provider, override|
    provider.gui = false
    provider.vmx["displayName"] = settings["guest"]["name"]
    provider.vmx["guestOS"] = "ubuntu-64"
    provider.vmx["numvcpus"] = settings["guest"]["cpus"].to_i
    provider.vmx["memsize"] = settings["guest"]["memory"].to_i
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

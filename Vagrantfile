# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Box: Ubuntu Raring Ringtail (13.04)
  config.vm.box = "raring64"

  # Network Setup
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.network :forwarded_port, guest: 3306, host: 3306

  # VirtualBox Configuration
  config.vm.provider :virtualbox do |provider, config|
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

    provider.gui = false
    provider.name = "Development"
    provider.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    provider.customize ["modifyvm", :id, "--memory", "1024"]
    provider.customize ["modifyvm", :id, "--acpi", "on"]
    provider.customize ["modifyvm", :id, "--ioapic", "on"]
    provider.customize ["modifyvm", :id, "--cpus", "4"]
    provider.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    provider.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    provider.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # VMware Workstation Configuration
  config.vm.provider :vmware_workstation do |provider, config|
    config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

    provider.gui = false
    provider.vmx["displayName"] = "Development"
    provider.vmx["guestOS"] = "ubuntu-64"
    provider.vmx["numvcpus"] = "4"
    provider.vmx["memsize"] = "1024"
  end

  # VMware Fusion Configuration
  config.vm.provider :vmware_fusion do |provider, override|
    config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

    provider.gui = false
    provider.vmx["displayName"] = "Development"
    provider.vmx["guestOS"] = "ubuntu-64"
    provider.vmx["numvcpus"] = "4"
    provider.vmx["memsize"] = "1024"
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

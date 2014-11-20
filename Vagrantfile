# -*- mode: ruby -*-
# vi: set ft=ruby :

# YAML
require 'yaml'

# Settings
file = File.expand_path('settings.yaml', File.dirname(__FILE__))
file = File.expand_path('settings.default.yaml', File.dirname(__FILE__)) if !File.exists?(file)
settings = YAML.load_file(file)

# Version
Vagrant.require_version '>= 1.6.0'

# Vagrant Configuration
Vagrant.configure('2') do |config|

  # Base Box
  config.vm.box = 'chef/ubuntu-14.10'

  # General
  config.vm.hostname = settings['guest']['hostname']

  # SSH
  config.ssh.forward_agent = true

  # Network Setup
  settings['vagrant']['ports'].each do |host_port, guest_port|
    config.vm.network :forwarded_port, guest: guest_port, host: host_port
  end

  # Synced Folders
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder 'provision', '/home/vagrant/provision'
  settings['vagrant']['folders'].each do |name, folder|
    config.vm.synced_folder name, folder['path']
  end

  # VirtualBox Configuration
  config.vm.provider :virtualbox do |provider, config|
    provider.gui = false
    provider.name = settings['guest']['name']
    provider.customize ['modifyvm', :id, '--ostype', 'Ubuntu_64']
    provider.customize ['modifyvm', :id, '--memory', settings['guest']['memory'].to_i]
    provider.customize ['modifyvm', :id, '--acpi', 'on']
    provider.customize ['modifyvm', :id, '--cpus', settings['guest']['cpus'].to_i]
    provider.customize ['modifyvm', :id, '--cpuexecutioncap', '100']
    provider.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    provider.customize ['modifyvm', :id, '--natdnsproxy1', 'on']

    if settings['guest']['cpus'].to_i > 1
      provider.customize ['modifyvm', :id, '--ioapic', 'on']
    end
  end

  # VMware Workstation Configuration
  config.vm.provider :vmware_workstation do |provider, config|
    provider.gui = false
    provider.vmx['displayName'] = settings['guest']['name']
    provider.vmx['guestOS'] = 'ubuntu-64'
    provider.vmx['numvcpus'] = settings['guest']['cpus'].to_i
    provider.vmx['memsize'] = settings['guest']['memory'].to_i
  end

  # VMware Fusion Configuration
  config.vm.provider :vmware_fusion do |provider, config|
    provider.gui = false
    provider.vmx['displayName'] = settings['guest']['name']
    provider.vmx['guestOS'] = 'ubuntu-64'
    provider.vmx['numvcpus'] = settings['guest']['cpus'].to_i
    provider.vmx['memsize'] = settings['guest']['memory'].to_i
  end

  # Provision
  config.vm.provision :shell, path: './provision/setup.sh'
  config.vm.provision :shell, path: './provision/boot.sh', run: 'always'

  # Caching
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end
end

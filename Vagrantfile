# -*- mode: ruby -*-
# vi: set ft=ruby :

# YAML
require 'yaml'

# Settings
file = File.expand_path('settings.yaml', File.dirname(__FILE__))
file = File.expand_path('settings.default.yaml', File.dirname(__FILE__)) if !File.exists?(file)
settings = YAML.load_file(file)

# Version
Vagrant.require_version '>= 1.7.0'

# Configuration
Vagrant.configure('2') do |config|

  # Base
  config.vm.box = 'chef/ubuntu-14.10'
  config.vm.hostname = settings['machine']['hostname']

  # SSH
  config.ssh.forward_agent = true

  # Ports
  config.vm.network :forwarded_port, guest: settings['services']['http'], host: 80 if settings['services']['http']
  config.vm.network :forwarded_port, guest: settings['services']['https'], host: 443 if settings['services']['https']
  config.vm.network :forwarded_port, guest: settings['services']['mysql'], host: 3306 if settings['services']['mysql']
  config.vm.network :forwarded_port, guest: settings['services']['redis'], host: 6379 if settings['services']['redis']

  # Folders
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder 'provision', '/home/vagrant/provision'
  config.vm.synced_folder 'backup', '/home/vagrant/backup'
  config.vm.synced_folder settings['hosts']['directory'], '/var/www'

  # VirtualBox
  config.vm.provider :virtualbox do |provider, config|
    provider.gui = false
    provider.name = settings['machine']['name']
    provider.customize ['modifyvm', :id, '--ostype', 'Ubuntu_64']
    provider.customize ['modifyvm', :id, '--memory', settings['machine']['memory'].to_i]
    provider.customize ['modifyvm', :id, '--acpi', 'on']
    provider.customize ['modifyvm', :id, '--cpus', settings['machine']['cpus'].to_i]
    provider.customize ['modifyvm', :id, '--cpuexecutioncap', '100']
    provider.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    provider.customize ['modifyvm', :id, '--natdnsproxy1', 'on']

    if settings['machine']['cpus'].to_i > 1
      provider.customize ['modifyvm', :id, '--ioapic', 'on']
    end
  end

  # VMware
  [:vmware_workstation, :vmware_fusion].each do |provider|
    config.vm.provider provider do |provider, config|
      provider.gui = false
      provider.vmx['displayName'] = settings['machine']['name']
      provider.vmx['guestOS'] = 'ubuntu-64'
      provider.vmx['numvcpus'] = settings['machine']['cpus'].to_i
      provider.vmx['memsize'] = settings['machine']['memory'].to_i
    end
  end

  # Provision
  config.vm.provision :shell, path: './provision/setup.sh'
  config.vm.provision :shell, path: './provision/boot.sh', run: 'always'

  # Caching
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end
end

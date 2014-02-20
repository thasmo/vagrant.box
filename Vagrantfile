# -*- mode: ruby -*-
# vi: set ft=ruby :

# YAML
require 'yaml'

# Settings
file = File.expand_path('settings.yaml', File.dirname(__FILE__))

if File.exists?(file)
  settings = YAML.load_file(file)
else
  abort('No settings.yaml file found.')
end

# Vagrant version
Vagrant.require_version '>= 1.4.0', '< 1.5.0'

# Vagrant Configuration
Vagrant.configure('2') do |config|

  # Base Box
  config.vm.box = settings['guest']['architecture'] == '64-bit' ? 'raring64' : 'raring32'

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
  settings['vagrant']['folders'].each do |name, folder|
    config.vm.synced_folder name, folder['path'], :nfs => folder['nfs']
  end

  # VirtualBox Configuration
  config.vm.provider :virtualbox do |provider, config|
    provider.gui = false
    provider.name = settings['guest']['name']
    provider.customize ['modifyvm', :id, '--ostype', settings['guest']['architecture'] == '64-bit' ? 'Ubuntu_64' : 'Ubuntu']
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
    provider.vmx['guestOS'] = settings['guest']['architecture'] == '64-bit' ? 'ubuntu-64' : 'ubuntu'
    provider.vmx['numvcpus'] = settings['guest']['cpus'].to_i
    provider.vmx['memsize'] = settings['guest']['memory'].to_i
  end

  # VMware Fusion Configuration
  config.vm.provider :vmware_fusion do |provider, config|
    provider.gui = false
    provider.vmx['displayName'] = settings['guest']['name']
    provider.vmx['guestOS'] = settings['guest']['architecture'] == '64-bit' ? 'ubuntu-64' : 'ubuntu'
    provider.vmx['numvcpus'] = settings['guest']['cpus'].to_i
    provider.vmx['memsize'] = settings['guest']['memory'].to_i
  end

  # Initialization Provisioning
  config.vm.provision :shell, :path => '.chef/initialization.sh'

  # Main Provisioning
  config.vm.provision :chef_solo do |chef|

    # Configuration
    chef.cookbooks_path = ['.chef/cookbook/generic/', '.chef/cookbook/specific/']
    chef.data_bags_path = '.chef/databag/'
    chef.roles_path = '.chef/role/'

    # Roles
    chef.add_role('base')
    chef.add_role('web')
    chef.add_role('email')
    chef.add_role('database')

    # Attributes
    chef.json = {
      'base' => {
        'domain' => settings['webserver']['domain'],
        'environment' => settings['webserver']['environment']
      }
    }
  end

  # Application Provisioning
  config.vm.provision :shell, :path => '.chef/application.sh'
end

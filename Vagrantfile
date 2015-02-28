# -*- mode: ruby -*-
# vi: set ft=ruby :

# YAML
require 'yaml'

# Settings
file = File.expand_path('settings.yaml', File.dirname(__FILE__))
file = File.expand_path('settings.default.yaml', File.dirname(__FILE__)) if !File.exists?(file)
settings = YAML.load_file(file)

# Ports
ports = {
  'apache' => {:http => 80, :https => 443},
  'nginx'  => {:http => 88, :https => 444}
}

# Version
Vagrant.require_version '>= 1.7.0'

# Configuration
Vagrant.configure('2') do |config|

  # Base
  config.vm.box = settings['machine']['box']
  config.vm.hostname = settings['machine']['hostname']

  # Ports
  config.vm.network :forwarded_port, guest: ports[settings['webserver']['engine']][:http], host: settings['services']['http'] if settings['services']['http']
  config.vm.network :forwarded_port, guest: ports[settings['webserver']['engine']][:https], host: settings['services']['https'] if settings['services']['https']
  config.vm.network :forwarded_port, guest: 3306, host: settings['services']['mysql'] if settings['services']['mysql']
  config.vm.network :forwarded_port, guest: 6379, host: settings['services']['redis'] if settings['services']['redis']
  config.vm.network :forwarded_port, guest: 35729, host: settings['services']['live-reload'] if settings['services']['live-reload']
  config.vm.network :forwarded_port, guest: 3000, host: settings['services']['browser-sync'] if settings['services']['browser-sync']
  settings['mappings']['ports'].to_a.each do |host, guest|
    config.vm.network :forwarded_port, guest: guest, host: host
  end

  # Folders
  config.vm.synced_folder settings['webserver']['directory'], '/var/www' if settings['webserver']['directory']
  config.vm.synced_folder './host/apache/', '/etc/apache2/sites-enabled/'
  config.vm.synced_folder './host/nginx/', '/etc/nginx/sites-enabled/'
  settings['mappings']['folders'].to_a.each do |path, folder|
    config.vm.synced_folder path, folder['path']
  end

  # SSH
  config.ssh.forward_agent = true

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

  # Parallels
  config.vm.provider :parallels do |provider, config|
    provider.gui = false
    provider.name = settings['machine']['name']
    provider.cpus = settings['machine']['cpus'].to_i
    provider.memory = settings['machine']['memory'].to_i
    provider.optimize_power_consumption = false
  end

  # Provision
  config.vm.provision :shell, inline: 'bash /vagrant/provision/install.sh'
  config.vm.provision :shell, inline: 'bash /vagrant/provision/configure.sh "$1" "$2" "$3"', run: 'always', args: [
    settings['environment']['variables'].map{|i| i.map{|k,v| "#{k}=#{v}"}}.join(' '),
    settings['webserver']['domains'].join('|'),
    settings['machine']['timezone']
  ]

  # Triggers
  if defined? VagrantPlugins::Triggers

    # Backup
    config.trigger.before [:halt, :suspend, :destroy], :stdout => true do
      run "vagrant ssh -c '/vagrant/provision/automation/backup.sh'"
    end
  end
end

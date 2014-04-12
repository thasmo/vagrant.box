apache_module 'actions'
apache_module 'vhost_alias'

execute 'disable-default-site' do
  command 'sudo a2dissite default'
end

execute 'remove-other-vhosts-access-logs' do
  command 'sudo rm -f /etc/apache2/conf.d/other-vhosts-access-log'
end

execute 'remove-all-enabled-sites' do
  command 'sudo rm -f /etc/apache2/sites-enabled/*'
end

execute 'remove-all-available-sites' do
  command 'sudo rm -f /etc/apache2/sites-available/*'
end

template node['apache']['dir'] + '/conf.d/custom.conf' do
  source 'apache/custom.conf.erb'
  mode 00644
  owner 'root'
  group node['apache']['root_group']
end

template node['apache']['dir'] + '/conf.d/environment.conf' do
  source 'apache/environment.conf.erb'
  mode 00644
  owner 'root'
  group node['apache']['root_group']
  variables :variables => node['base']['environment']
end

template node['apache']['dir'] + '/conf.d/hosts.conf' do
  source 'apache/hosts.conf.erb'
  mode 00644
  owner 'root'
  group node['apache']['root_group']
  variables :domain => node['base']['domain']
end

template node['apache']['dir'] + '/conf.d/php.conf' do
  source 'apache/php.conf.erb'
  mode 00644
  owner 'root'
  group node['apache']['root_group']
end

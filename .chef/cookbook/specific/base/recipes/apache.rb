execute 'remove-other-vhosts-access-logs' do
  command 'sudo rm -f /etc/apache2/conf-enabled/other-vhosts-access-log'
end

execute 'remove-all-enabled-sites' do
  command 'sudo rm -f /etc/apache2/sites-enabled/*'
end

template node['apache']['dir'] + '/conf-available/custom.conf' do
  source 'apache/custom.conf.erb'
  mode 00644
  owner 'root'
  group node['apache']['root_group']
  variables :variables => node['base']['environment']
end

link node['apache']['dir'] + '/conf-enabled/custom.conf' do
  to node['apache']['dir'] + '/conf-available/custom.conf'
end

template node['apache']['dir'] + '/conf-available/hosts.conf' do
  source 'apache/hosts.conf.erb'
  mode 00644
  owner 'root'
  group node['apache']['root_group']
  variables :domain => node['base']['domain']
end

link node['apache']['dir'] + '/conf-enabled/hosts.conf' do
  to node['apache']['dir'] + '/conf-available/hosts.conf'
end

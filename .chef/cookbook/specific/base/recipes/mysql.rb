cookbook_file '/etc/mysql/conf.d/custom.cnf' do
  source 'mysql-custom.cnf'
  mode 0755
  owner 'root'
  group 'root'

  notifies :restart, 'mysql_service[default]', :delayed
end

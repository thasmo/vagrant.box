cookbook_file '/etc/mysql/conf.d/charset.cnf' do
  source 'mysql-charset.cnf'
  mode 0755
  owner 'root'
  group 'root'

  notifies :restart, 'mysql_service[default]', :delayed
end

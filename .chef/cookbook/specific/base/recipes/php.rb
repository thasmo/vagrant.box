cookbook_file '/etc/php5/conf.d/00-custom.ini' do
  source 'php-custom.ini'
  mode 0755
  owner 'root'
  group 'root'
end

php_pear 'igbinary' do
  action :install
end

service 'php5-fpm' do
  action :restart
end

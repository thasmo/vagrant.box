php_pear "igbinary" do
  action :install
end

service "php5-fpm" do
  action :restart
end

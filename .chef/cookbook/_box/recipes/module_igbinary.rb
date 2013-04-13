php_pear "igbinary" do
  action :install
end

cookbook_file "/etc/php5/mods-available/igbinary.ini" do
  source "igbinary.ini"
  mode 0644
  owner "root"
  group "root"
end

link '/etc/php5/conf.d/20-igbinary.ini' do
  to '../mods-available/igbinary.ini'
end

service "php5-fpm" do
  action :restart
end

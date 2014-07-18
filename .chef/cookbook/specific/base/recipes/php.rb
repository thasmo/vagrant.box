cookbook_file '/etc/php5/fpm/conf.d/00-custom.ini' do
  source 'php-custom.ini'
  mode 0755
  owner 'root'
  group 'root'
end

link '/etc/php5/fpm/conf.d/20-mcrypt.conf' do
  to '../../mods-available/mcrypt.ini'
end

execute 'enable-php5-mcrypt' do
  command 'php5enmod mcrypt'
end

execute 'restart-php5-fpm' do
  command 'service php5-fpm restart'
end

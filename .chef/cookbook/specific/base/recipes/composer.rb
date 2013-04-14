include_recipe 'php'

directory '/opt/php-composer/'

remote_file '/opt/php-composer/composer.phar' do
	source 'http://getcomposer.org/composer.phar'
	mode 0755
end

link '/usr/local/bin/composer' do
	to '/opt/php-composer/composer.phar'
end

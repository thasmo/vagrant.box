name 'web'
description 'Sets up a web server'

# Runlist
run_list(

  # Common
  'recipe[memcached]',
  'recipe[imagemagick]',
  'recipe[sqlite]',

  # Apache
  'recipe[apache2]',

  # PHP
  'recipe[php]',
  'recipe[php::module_memcache]',
  'recipe[php::module_curl]',
  'recipe[php::module_gd]',
  'recipe[php::module_sqlite3]',
  'recipe[php::module_mysql]',
  'recipe[php::module_ldap]',

  # Base
  'recipe[base::apache]',
  'recipe[base::php]',
)

# Attributes
override_attributes(
  'memcached' => {
    'memory' => 256,
  },
  'apache' => {
    'version' => '2.4',
    'listen_ports' => %w(80 443),
    'default_modules' => %w(
      auth_basic authn_core authn_file authz_core authz_groupfile authz_host authz_user
      alias actions dir env fastcgi mime negotiation rewrite setenvif ssl vhost_alias
    ),
  },
  'php' => {
    'packages' => ['php5-fpm', 'php5-cli', 'php-pear', 'php5-mcrypt', 'php5-intl'],
    'conf_dir' => '/etc/php5/fpm',
  }
)

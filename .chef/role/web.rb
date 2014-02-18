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
  'recipe[apache2::mod_fastcgi]',
  'recipe[apache2::mod_rewrite]',
  'recipe[apache2::mod_deflate]',
  'recipe[apache2::mod_expires]',
  'recipe[apache2::mod_headers]',
  'recipe[apache2::mod_env]',
  'recipe[apache2::mod_setenvif]',
  'recipe[apache2::mod_alias]',
  'recipe[apache2::mod_auth_basic]',
  'recipe[apache2::mod_dir]',
  'recipe[apache2::mod_ssl]',

  # PHP
  'recipe[php]',
  'recipe[php::module_apc]',
  'recipe[php::module_memcache]',
  'recipe[php::module_curl]',
  'recipe[php::module_gd]',
  'recipe[php::module_sqlite3]',
  'recipe[php::module_mysql]',

  # Base
  'recipe[base::apache]',
  'recipe[base::php]',
)

# Attributes
override_attributes(
  'memcached' => {
    'memory' => 128,
  },
  'php' => {
    'packages' => ['php5-fpm', 'php5-cli', 'php-pear', 'php5-mcrypt', 'php5-intl'],
    'conf_dir' => '/etc/php5/fpm',
  }
)

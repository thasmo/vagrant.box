name "web"
description "Sets up a web server"

# Runlist
run_list(

  # Common
  "recipe[memcached]",
  "recipe[imagemagick]",
  "recipe[sqlite]",

  # Apache
  "recipe[apache2]",
  "recipe[apache2::mod_fastcgi]",
  "recipe[apache2::mod_rewrite]",
  "recipe[apache2::mod_deflate]",
  "recipe[apache2::mod_expires]",
  "recipe[apache2::mod_headers]",
  "recipe[apache2::mod_env]",
  "recipe[apache2::mod_setenvif]",
  "recipe[apache2::mod_alias]",
  "recipe[apache2::mod_auth_basic]",
  "recipe[apache2::mod_dir]",
  "recipe[apache2::mod_ssl]",

  # PHP
  "recipe[php]",
  "recipe[php::module_apc]",
  "recipe[php::module_memcache]",
  "recipe[php::module_curl]",
  "recipe[php::module_gd]",
  "recipe[php::module_sqlite3]",
  "recipe[php::module_mysql]",

  # Base
  "recipe[_box::module_igbinary]",
  "recipe[_box::mod_vhost_alias]",
  "recipe[_box::mod_actions]",
  "recipe[_box::hosts]",
  "recipe[_box::composer]",
  "recipe[_box::mail]",
  "recipe[_box::phing]",
)

# Attributes
override_attributes(
  "php" => {
    "packages" => ["php5-fpm", "php5-dev", "php5-cli", "php-pear", "php5-mcrypt", "php5-ffmpeg"],
    "conf_dir" => "/etc/php5/fpm",
    "directives" => {
      "expose_php" => "On",
      "default_charset" => "utf-8",
      "display_errors" => "On",
      "error_reporting" => "E_ALL",
      "memory_limit" => "256M",
      "post_max_size" => "128M",
      "upload_max_filesize" => "128M",
      "max_file_uploads" => "20",
      "date.timezone" => "UTC",
      "phar.readonly" => "Off",
      "mail.add_x_header" => "Off",
      "session.serialize_handler" => "igbinary",
      "apc.shm_size" => "256M",
      "apc.max_file_size" => "1M",
      "apc.num_files_hint" => "10000",
      "apc.user_entries_hint" => "10000",
      "apc.serializer" => "igbinary",
    }
  }
)

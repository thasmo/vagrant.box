name 'database'
description 'Sets up a database server'

# Runlist
run_list(

  # MySQL Server
  'recipe[mysql::server]',
  'recipe[base::mysql]'
)

# Attributes
override_attributes(
  'mysql' => {
    'version'                => '5.6',
    'server_root_password'   => '',
    'server_debian_password' => '',
    'allow_remote_root'      => true
  }
)

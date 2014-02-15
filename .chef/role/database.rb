name 'database'
description 'Sets up a database server'

# Runlist
run_list(

  # MySQL Server
  'recipe[mysql::server]',
)

# Attributes
override_attributes(
  'mysql' => {
    'server_root_password' => '',
    'server_repl_password' => '',
    'server_debian_password' => '',
    'bind_address' => '0.0.0.0',
    'allow_remote_root' => true,
    'tunable' => {
      'skip-name-resolve' => true,
    }
  }
)

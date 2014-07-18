name 'base'
description 'Sets up a basic server'

# Runlist
run_list(

  # Common
  'recipe[ubuntu]',
  'recipe[locale]',
  'recipe[cron]',
  'recipe[openssl]',
  'recipe[base::ssl-cert]',
  'recipe[base::zip]'
)

# Attributes
override_attributes(
  'ubuntu' => {
    'archive_url' => 'mirror://mirrors.ubuntu.com/mirrors.txt',
    'include_source_packages' => false,
  }
)

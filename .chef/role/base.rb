name 'base'
description 'Sets up a basic server'

# Runlist
run_list(

  # Common
  'recipe[locale]',
  'recipe[cron]',
  'recipe[openssl]',
  'recipe[base::ssl-cert]',
  'recipe[base::zip]'
)

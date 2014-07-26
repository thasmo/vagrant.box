name 'email'
description 'Sets up an email server'

# Runlist
run_list(

  # Postfix
  'recipe[postfix]',

  # Dovecot
  'recipe[dovecot]',
)

# Attributes
override_attributes(
  'postfix' => {
    'main' => {
      'smtp_sasl_auth_enable' => 'yes',
      'home_mailbox' => 'Maildir/',
      'mailbox_command' => '',
      'use_virtual_aliases' => 'yes',
      'virtual_alias_maps' => 'regexp:/etc/postfix/virtual',
    },
    'virtual_aliases' => {
      '/.*/' => 'vagrant',
    }
  },
  'dovecot' => {
    'conf' => {
      'ssl' => false,
      'ssl_cert' => '',
      'ssl_key' => '',
      'disable_plaintext_auth' => false,
      'mail_location' => 'maildir:~/Maildir',
    },
    'protocols' => {
      'imap' => {}
    },
    'auth' => {
      'system' => {}
    }
  }
)

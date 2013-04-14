name "email"
description "Sets up an email server"

# Runlist
run_list(

  # Dovecot + Postfix
  "recipe[_box::mail]",
)

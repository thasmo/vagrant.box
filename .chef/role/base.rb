name "base"
description "Sets up a basic server"

# Runlist
run_list(

  # Common
  "recipe[ubuntu]",
  "recipe[build-essential]",
  "recipe[locale]",
  "recipe[cron]",
  "recipe[openssl]",
)

# Attributes
override_attributes(
 "ubuntu" => {
    "archive_url" => "mirror://mirrors.ubuntu.com/mirrors.txt",
    "include_source_packages" => false,
  }
)

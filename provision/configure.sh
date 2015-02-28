#!/usr/bin/env bash

option=$1
data=$2

case $option in
  "environment")
    echo "Configuring environment ..."

    # empty files
    > "/etc/nginx/environment.conf"
    > "/etc/apache2/conf-enabled/environment.conf"

    # process variables
    assignments=$(echo $data | tr " " "\n")

    for assignment in $assignments
    do
      parts=($(echo $assignment | tr "=" "\n"))
      echo "fastcgi_param ${parts[0]} '${parts[1]}';" >> "/etc/nginx/environment.conf"
      echo "SetEnv ${parts[0]} ${parts[1]}" >> "/etc/apache2/conf-enabled/environment.conf"
    done

    ;;

  "hosts")
    echo "Configuring hosts ..."

    # Apache
    contents=$(< /vagrant/provision/configuration/apache/host/default.conf)
    contents=$(echo "$contents" | sed -e "s/\$DOMAINS/$data/g")
    echo "$contents" > /etc/apache2/hosts.conf

    # Nginx
    contents=$(< /vagrant/provision/configuration/nginx/host/default.conf)
    contents=$(echo "$contents" | sed -e "s/\$DOMAINS/$data/g")
    echo "$contents" > /etc/nginx/hosts.conf

    ;;

  "timezone")
    echo "Configuring timezone ..."

    # Server
    echo "$data" > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata &> /dev/null

    # PHP CLI
    contents=$(< /vagrant/provision/configuration/php/php-cli.ini)
    contents=$(echo "$contents" | sed -e "s@\$TIMEZONE@$data@g")
    echo "$contents" > /etc/php5/cli/conf.d/99-custom.ini

    # PHP FPM
    contents=$(< /vagrant/provision/configuration/php/php-fpm.ini)
    contents=$(echo "$contents" | sed -e "s@\$TIMEZONE@$data@g")
    echo "$contents" > /etc/php5/fpm/conf.d/99-custom.ini

    ;;

  *)
    $0 "environment" "$1"
    $0 "hosts" "$2"
    $0 "timezone" "$3"

    echo "Restarting services ..."

    service nginx restart &> /dev/null
    service apache2 restart &> /dev/null
    service php5-fpm restart &> /dev/null

    echo "Ready."
    ;;
esac

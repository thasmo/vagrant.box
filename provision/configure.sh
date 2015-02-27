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
    contents=$(echo "$contents" | sed -e "s/\$DOMAINS/$2/g")
    echo "$contents" > /etc/apache2/sites-available/000-default.conf

    # Nginx
    contents=$(< /vagrant/provision/configuration/nginx/host/default.conf)
    contents=$(echo "$contents" | sed -e "s/\$DOMAINS/$2/g")
    echo "$contents" > /etc/nginx/sites-available/default

    ;;

  *)
    $0 "environment" "$1"
    $0 "hosts" "$2"
    service nginx restart
    service apache2 restart
    ;;
esac

#!/usr/bin/env bash

option=$1
data=$2

case $option in
  "environment")
    echo "Configuring environment ..."

    # empty file
    > "/etc/nginx/environment.conf"

    # process variables
    assignments=$(echo $data | tr " " "\n")

    for assignment in $assignments
    do
      parts=($(echo $assignment | tr "=" "\n"))
      echo "fastcgi_param ${parts[0]} '${parts[1]}';" >> "/etc/nginx/environment.conf"
    done

    service nginx restart
    ;;

  "hosts")
    echo "Configuring hosts ..."
    END_DATE=$arg
    ;;
esac

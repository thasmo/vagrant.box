#!/usr/bin/env bash

NOW=$(date +"%Y%m%d%H%M%S")

# MySQL
mysqldump --all-databases | gzip > /vagrant/backup/mysql/$NOW.sql.gz

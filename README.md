# Vagrant Box
A LAMP Vagrant box for web development.

## Status
Work in progress.

## Contents
* Apache 2.4
* PHP 5.5 (FPM)
* MySQL 5.6
* Memcached
* Cron
* Dovecot + Postfix
* Image Magick
* Locale
* SQLite
* Zip

## Prerequisites
* Vagrant >= 1.6.0
* VirtualBox or VMWare Workstation/Fusion
* Librarian Chef

## Installation
* Clone the repository
* Run `librarian-chef install` to install cookbooks
* Copy `settings.dist.yaml` to `settings.yaml`
* Adjust `settings.yaml` to your needs
* Run `vagrant up` to run the initial provisioning

## Usage

#### Hosts
Virtual hosts in the `host` directory will be served by Apache.
Files inside `host/project/htdocs/` will be accessible via `http://project.local/`,
where `local` refers to the configured domain in the `settings.yaml` file.

#### E-Mails
All emails sent won't be delivered to their recipients, they will be stored
in the local `vagrant` user's mailbox which you can easily access via IMAP
using `vagrant` as password. It'd also be possible to just install a webmail
client like roundcube and use it to read the emails.

## Notes
Only tested on Windows using VirtualBox.

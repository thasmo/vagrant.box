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

### Apache modules
`auth_basic`, `authn_core`, `authn_file`, `authz_core`, `authz_groupfile`, `authz_host`, `authz_user`, `alias`,
`actions`, `dir`, `env`, `fastcgi`, `mime`, `negotiation`, `rewrite`, `setenvif`, `ssl`, `vhost_alias`

### PHP modules
`core`, `date`, `ereg`, `libxml`, `openssl`, `pcre`, `zlib`, `bcmath`, `bz2`, `calendar`, `ctype`, `dba`, `dom`,
`hash`, `fileinfo`, `filter`, `ftp`, `gettext`, `SPL`, `iconv`, `mbstring`, `session`, `posix`, `reflection`,
`standard`, `shmop`, `simplexml`, `soap`, `sockets`, `phar`, `exif`, `sysvmsg`, `sysvsem`, `sysvshm`, `tokenizer`,
`wddx`, `xml`, `xmlreader`, `xmlwriter`, `zip`, `cgi-fcgi`, `PDO`, `curl`, `gd`, `intl`, `json`, `ldap`, `mcrypt`,
`memcache`, `mysql`, `mysqli`, `pdo_mysql`, `pdo_sqlite`, `readline`, `sqlite3`, `mhash`, `opcache`

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

## Configuration

### PHP

It's possible to define PHP settings per directory using [.user.ini files](http://php.net/manual/en/configuration.file.per-user.php).
Note that the INI directive `user_ini.cache_ttl` has been lowered to 10 seconds to detect changes faster.
Defining PHP settings in `.htaccess` files doesn't work because PHP is not running as Apache module.

### MySQL

MySQL has been set up to use the `utf8` charset and `utf8_unicode_ci` collation by default.

## Usage

### Hosts
Virtual hosts in the `host` directory will be served by Apache.
Files inside `host/project/htdocs/` will be accessible via `http://project.local/`,
where `local` refers to the configured domain in the `settings.yaml` file.

### E-Mails
All emails sent won't be delivered to their recipients, they will be stored
in the local `vagrant` user's mailbox which you can easily access via IMAP
using `vagrant` as password. It'd also be possible to just install a webmail
client like roundcube and use it to read the emails.

## Notes
Only tested on Windows using VirtualBox.

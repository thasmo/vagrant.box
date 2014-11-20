# Vagrant Box
A LEMP Vagrant box for web development.

## Status
Work in progress.

## Software
* Ubuntu 14.10 64-bit
* Nginx 1.6
* PHP 5.6 (FPM)
* Composer
* MySQL 5.6
* Redis 2.8
* Memcached 1.4
* Git 2.1
* Node.js 0.10
* SQLite

### Apache Modules
`auth_basic`, `authn_core`, `authn_file`, `authz_core`, `authz_groupfile`, `authz_host`, `authz_user`, `alias`,
`actions`, `dir`, `env`, `fastcgi`, `mime`, `negotiation`, `rewrite`, `setenvif`, `ssl`, `vhost_alias`

### PHP Modules
`core`, `date`, `ereg`, `libxml`, `openssl`, `pcre`, `zlib`, `bcmath`, `bz2`, `calendar`, `ctype`, `dba`, `dom`,
`hash`, `fileinfo`, `filter`, `ftp`, `gettext`, `SPL`, `iconv`, `mbstring`, `session`, `posix`, `reflection`,
`standard`, `shmop`, `simplexml`, `soap`, `sockets`, `phar`, `exif`, `sysvmsg`, `sysvsem`, `sysvshm`, `tokenizer`,
`wddx`, `xml`, `xmlreader`, `xmlwriter`, `zip`, `cgi-fcgi`, `PDO`, `curl`, `gd`, `intl`, `json`, `ldap`, `mcrypt`,
`memcache`, `mysql`, `mysqli`, `pdo_mysql`, `pdo_sqlite`, `readline`, `sqlite3`, `mhash`, `opcache`

### Node Modules (global)
`gulp`, `grunt-cli`, `bower`

## Prerequisites
* Vagrant >= 1.6.0
* VirtualBox or VMWare Workstation/Fusion

## Installation
* Clone the repository
* Copy `settings.default.yaml` to `settings.yaml`
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
Virtual hosts in the `hosts directory` will be served by Nginx. Files inside a host directory are publicly accessible except you create a sub-directory called `public`, `htdocs` or `httpdocs` which makes Nginx serve files from within one of these directories and all outside files won't be publicly accessible. SSL is configured and files will be served from within the same public directory.

### E-Mails
All emails sent won't be delivered to their recipients, they will be stored
in the local `vagrant` user's mailbox which you can easily access via IMAP
using `vagrant` as password. It'd also be possible to just install a webmail
client like roundcube and use it to read the emails.

## Notes
Only tested on Windows using VirtualBox.

# Vagrant Box
A custom Vagrant Box for PHP Web Development.

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

### PHP Modules
`apc`, `apcu`, `bcmath`, `bz2`, `calendar`, `cgi-fcgi`, `core`, `ctype`, `curl`, `date`, `dba`, `dom`, `ereg`, `exif`,
`fileinfo`, `filter`, `ftp`, `gd`, `gettext`, `gmp`, `hash`, `iconv`, `imap`, `intl`, `json`, `libxml`, `mbstring`,
`mcrypt`, `memcached`, `mhash`, `mysql`, `mysqli`, `mysqlnd`, `opcache`, `openssl`, `pcre`, `pdo`, `pdo_mysql`,
`pdo_sqlite`, `phar`, `posix`, `readline`, `redis`, `reflection`, `session`, `shmop`, `simplexml`, `soap`, `sockets`,
`spl`, `sqlite3`, `standard`, `sysvmsg`, `sysvsem`, `sysvshm`, `tokenizer`, `wddx`, `xdebug`, `xml`, `xmlreader`,
`xmlwriter`, `zip`, `zlib`

### Node Modules (global)
`gulp`, `grunt-cli`, `bower`

## Prerequisites
* Vagrant >= 1.7.0
* VirtualBox, VMWare Workstation/Fusion or Parallels

## Installation
* Clone the repository
* Copy `settings.default.yaml` to `settings.yaml`
* Adjust `settings.yaml` to your needs
* Run `vagrant up` to run the initial provisioning

## Configuration

### PHP
It's possible to define PHP settings per directory using [.user.ini files](http://php.net/manual/en/configuration.file.per-user.php).
Note that the INI directive `user_ini.cache_ttl` has been lowered to 10 seconds to detect changes faster.

### MySQL
MySQL has been set up to use the `utf8` charset and `utf8_unicode_ci` collation by default.

## Usage

### Hosts
Virtual hosts in the `hosts directory` will be served by Nginx. Files inside a host directory are publicly accessible
except you create a sub-directory called `public`, `htdocs` or `httpdocs` which makes Nginx serve files from within 
one of these directories and all outside files won't be publicly accessible. SSL is configured and files will be 
served from within the same public directory.

### Domains
Support for various *loopback/tunnel* providers is baked in. Supported are:

- [localtunnel.me]
- [vagrantshare.com]
- [ngrok.com]
- [forwardhq.com]
- [xip.io]

Valid domains which map to host directories are:

- *project.com*.[settings.hosts.domains]
- *project.com*.localhost
- *project.com*.localtunnel.me
- *project.com*.vagrantshare.com
- *project.com*.ngrok.com
- *project.com*.fwd.wf
- *project.com*.192.168.0.1.xip.io

`project.com` will map to the directory `[settings.hosts.directory]/project.com/(public|htdocs|httpdocs)`.

### E-Mails
All emails sent won't be delivered to their recipients, they will be stored
in the local `vagrant` user's mailbox which you can easily access via IMAP
using `vagrant` as password. It'd also be possible to just install a webmail
client like roundcube and use it to read the emails.

## Settings
- *machine*
    - *box*: Name of the base box to use. Can be a local box or a box hosted on Atlas.
    - *name*: Name of the VM, which is displayed in the GUI of the provider. Should be unique per provider.
    - *hostname*: Defines the hostname of the VM.
    - *memory*: Amount of RAM in MB the VM will be assigned.
    - *cpus*: Number of virtual CPU cores the VM will be assigned.
- *services*
    - *http*: Local port number to map the HTTP service to.
    - *https*: Local port number to map the HTTPS service to.
    - *mysql*: Local port number to map the MySQL server to.
    - *redis*: Local port number to map the Redis server to.
- *hosts*
    - *domains*: List of local top-level-domains.
    - *directory*: Local path of the hosts directory. Can be relative or absolute.
- *environment*
    - *variables*: List of environment variables to set for the VM's web-server.

## Notes
Only tested on Windows 8.1 using VMware Workstation 11.

[localtunnel.me]: http://localtunnel.me/
[vagrantshare.com]: http://vagrantshare.com/
[ngrok.com]: http://ngrok.com/
[fwd.wf]: https://forwardhq.com/
[forwardhq.com]: https://forwardhq.com/
[xip.io]: http://xip.io/

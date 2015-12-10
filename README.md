# Vagrant Box
A custom Vagrant Box for PHP Web Development.

## Goals and Principles
* Convention over Configuration
* Optimize for Performance
* Multi-Project Support
* Latest Software
* Solid Backup Strategy
* Comprehensive Documentation
* Automate everything

## Status
Work in progress.

## Software
* Ubuntu 15.04 64-bit
* Apache 2.4
* Nginx 1.8
* PHP 5.6 (FPM)
* Composer
* MySQL 5.6
* Redis 3.0
* Memcached 1.4
* Git 2.x
* Node.js 5.x
* npm 3.x
* SQLite 3.8

### Apache Modules
`access_compat`, `actions`, `alias`, `auth_basic`, `authn_core`, `authn_file`, `authz_core`, `authz_groupfile`,
`authz_host`, `authz_user`, `autoindex`, `deflate`, `dir`, `env`, `filter`, `mime`, `mpm_event`, `negotiation`,
`proxy`, `proxy_fcgi`, `rewrite`, `setenvif`, `socache_shmcb`, `ssl`, `status`, `vhost_alias`

### PHP Modules
`apc`, `apcu`, `bcmath`, `bz2`, `calendar`, `cgi-fcgi`, `core`, `ctype`, `curl`, `date`, `dba`, `dom`, `ereg`, `exif`,
`fileinfo`, `filter`, `ftp`, `gd`, `gettext`, `gmp`, `hash`, `iconv`, `imap`, `intl`, `json`, `libxml`, `mbstring`,
`mcrypt`, `memcached`, `mhash`, `mysql`, `mysqli`, `mysqlnd`, `opcache`, `openssl`, `pcre`, `pdo`, `pdo_mysql`,
`pdo_sqlite`, `phar`, `posix`, `readline`, `redis`, `reflection`, `session`, `shmop`, `simplexml`, `soap`, `sockets`,
`spl`, `sqlite3`, `standard`, `sysvmsg`, `sysvsem`, `sysvshm`, `tokenizer`, `wddx`, `xdebug`, `xml`, `xmlreader`,
`xmlwriter`, `zip`, `zlib`

### Node Modules (global)
`gulp`, `grunt-cli`, `bower`, `yo`

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
MySQL has been set up to use the `utf8mb4` character-set and `utf8mb4_unicode_ci` collation by default.

## Usage

### Hosts
Virtual hosts in the `hosts directory` will be served by the configured web-server.

#### Nginx
Files inside a host directory are publicly accessible except you create a sub-directory called `public`, `htdocs` or
`httpdocs` which makes Nginx serve files from within one of these directories and all outside files won't be publicly
accessible. SSL is configured and files will be served from within the same public directory.

Hostnames will map to directories in a certain way. Nginx will check if the given hostname maps to an existing
directory or will strip off subdomains as long as a directory matches. This enables having subdomains pointing
to a single host directory.

Imagine the domain `username.members.project.com.local`. The last part `local` will be ignored. The leading part
`username.members.project.com` will be used to determine the host directory by looking up if a directory with the
same name exists or, otherwise, stripping of `username`, then `members` and even `project` to find an existing one.

Furthermore Nginx will check if one of the directories `public`, `htdocs` or `httpdocs` exist inside the determined
directory and if, will use it as the public directory and map the hostname to it, otherwise not.

#### Apache
Files will be served publicly for each host from within a subdirectory named `htdocs`. Apache doesn't support
"on-the-fly" configuration of the final document root directory path like Nginx does. If you need to changed the
directory name of the document root path, have a look at the next chapter - `custom hosts`.

Nevertheless, Apache still support wildcard subdomains, which means `username.members.project.com.local` will be mapped
to the host's public directory path `username.members.project.com/htdocs`. Apache does not support determining the
final document root path by stripping of subdomain parts.

#### Custom Hosts
Host configuration files stored in `hosts/apache` and `hosts/nginx` will be loaded automatically, depending on which
web-server you have configured to be used.

#### Loopback Providers
Support for various *loopback/tunnel* providers is baked in. Supported are:

- [localtunnel.me]
- [vagrantshare.com]
- [ngrok.com]
- [forwardhq.com]
- [xip.io]

Valid domains which map to host directories are:

- *project.com*.localtunnel.me
- *project.com*.vagrantshare.com
- *project.com*.ngrok.com
- *project.com*.fwd.wf
- *project.com*.192.168.0.1.xip.io

`project.com` will map to the directory `[settings.hosts.directory]/project.com/`.

### E-Mails
All emails sent won't be delivered to their recipients, they will be stored
in the local `vagrant` user's mailbox which you can easily access via IMAP
using `vagrant` as password. It's also be possible to just install a webmail
client like roundcube and use it to read the emails.

## Backup
The MySQL databases get dumped every hour into the directory `backup/mysql`.
[Optionally](#triggers) they'll be dumped on every `halt`, `,suspend`, or `destroy`.

## Plugins

### Triggers
If installed, the `vagrant-triggers` plugin is used to create database backups,
before halting, suspending or destroying the VM. If the plugin is not installed
database backups will still be created every hour.

## Settings
- *machine*
    - *box*: Name of the base box to use. Can be a local box or a box hosted on Atlas.
    - *version*: Version constraint for the base box version to use.
    - *name*: Name of the VM, which is displayed in the GUI of the provider. Should be unique per provider.
    - *hostname*: Defines the hostname of the VM.
    - *memory*: Amount of RAM in MB the VM will be assigned.
    - *cpus*: Number of virtual CPU cores the VM will be assigned.
    - *timezone*: Defines the server's timezone.
- *services*
    - *http*: Local port number to map the HTTP service to.
    - *https*: Local port number to map the HTTPS service to.
    - *mysql*: Local port number to map the MySQL server to.
    - *redis*: Local port number to map the Redis server to.
- *webserver*
    - *engine*: `apache` or `nginx` available.
    - *domains*: List of local top-level-domains.
    - *directory*: Local path of the hosts directory. Can be relative or absolute.
- *environment*
    - *variables*: List of environment variables to set for the VM's web-server.
- *mappings*
    - *folders*: List of custom synced folders.
    - *ports*: List of custom forwarded ports.

Run `vagrant reload` to apply changes made in settings.yaml.

## Notes
Only tested on Windows 8.1 using VMware Workstation 11.

[localtunnel.me]: http://localtunnel.me/
[vagrantshare.com]: http://vagrantshare.com/
[ngrok.com]: http://ngrok.com/
[fwd.wf]: https://forwardhq.com/
[forwardhq.com]: https://forwardhq.com/
[xip.io]: http://xip.io/

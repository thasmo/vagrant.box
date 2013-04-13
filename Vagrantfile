# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	# Box: Ubuntu Raring Ringtail (13.04)
	config.vm.box = "raring"
	config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

	# Network Setup
	config.vm.network :forwarded_port, guest: 80, host: 80
	config.vm.network :forwarded_port, guest: 443, host: 443
	config.vm.network :forwarded_port, guest: 3306, host: 3306

	# VM Configuration
	config.vm.provider :virtualbox do |vb|
		vb.gui = false
		vb.name = "Development"
		vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
		vb.customize ["modifyvm", :id, "--memory", "1024"]
		vb.customize ["modifyvm", :id, "--acpi", "on"]
		vb.customize ["modifyvm", :id, "--ioapic", "on"]
		vb.customize ["modifyvm", :id, "--cpus", "4"]
		vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	end

	# Initialization Provisioning
	config.vm.provision :shell, :path => ".chef/initialization.sh"

	# Main Provisioning
	config.vm.provision :chef_solo do |chef|

		# Configuration
		chef.json = {
			"ubuntu" => {
				"archive_url" => "mirror://mirrors.ubuntu.com/mirrors.txt",
				"include_source_packages" => false,
			},
			"mysql" => {
				"server_root_password" => "",
				"server_repl_password" => "",
				"server_debian_password" => "",
			},
			"php" => {
				"packages" => ["php5-fpm", "php5-dev", "php5-cli", "php-pear", "php5-mcrypt", "php5-ffmpeg"],
				"conf_dir" => "/etc/php5/fpm",
				"directives" => {
					"expose_php" => "On",
					"default_charset" => "utf-8",
					"display_errors" => "On",
					"error_reporting" => "E_ALL",
					"memory_limit" => "256M",
					"post_max_size" => "128M",
					"upload_max_filesize" => "128M",
					"max_file_uploads" => "20",
					"date.timezone" => "UTC",
					"phar.readonly" => "Off",
					"mail.add_x_header" => "Off",
					"session.serialize_handler" => "igbinary",
					"apc.shm_size" => "256M",
					"apc.max_file_size" => "1M",
					"apc.num_files_hint" => "10000",
					"apc.user_entries_hint" => "10000",
					"apc.serializer" => "igbinary",
				}
			}
		}

		# Chef
		chef.cookbooks_path = ".chef/cookbook/"
		chef.data_bags_path = ".chef/databag/"
		chef.roles_path = ".chef/role/"

		# Common
		chef.add_recipe("ubuntu")
		chef.add_recipe("build-essential")
		chef.add_recipe("locale")
		chef.add_recipe("cron")
		chef.add_recipe("openssl")
		chef.add_recipe("memcached")
		chef.add_recipe("imagemagick")
		chef.add_recipe("sqlite")
		chef.add_recipe("mysql::server")

		# Apache
		chef.add_recipe("apache2")
		chef.add_recipe("apache2::mod_fastcgi")
		chef.add_recipe("apache2::mod_rewrite")
		chef.add_recipe("apache2::mod_deflate")
		chef.add_recipe("apache2::mod_expires")
		chef.add_recipe("apache2::mod_headers")
		chef.add_recipe("apache2::mod_env")
		chef.add_recipe("apache2::mod_setenvif")
		chef.add_recipe("apache2::mod_alias")
		chef.add_recipe("apache2::mod_auth_basic")
		chef.add_recipe("apache2::mod_dir")
		chef.add_recipe("apache2::mod_ssl")

		# PHP
		chef.add_recipe("php")
		chef.add_recipe("php::module_apc")
		chef.add_recipe("php::module_memcache")
		chef.add_recipe("php::module_curl")
		chef.add_recipe("php::module_gd")
		chef.add_recipe("php::module_sqlite3")
		chef.add_recipe("php::module_mysql")

		# Base
		chef.add_recipe("_box::module_igbinary")
		chef.add_recipe("_box::mod_vhost_alias")
		chef.add_recipe("_box::mod_actions")
		chef.add_recipe("_box::hosts")
		chef.add_recipe("_box::composer")
		chef.add_recipe("_box::mail")
		chef.add_recipe("_box::phing")
	end
end

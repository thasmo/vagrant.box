# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	# Box: Ubuntu Quantal Quetzal (12.10)
	#config.vm.box = "quantal"
	#config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/quantal/current/quantal-server-cloudimg-amd64-vagrant-disk1.box"

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
		vb.customize ["modifyvm", :id, "--memory", "1024"]
		vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
	end

	# Chef Solo Provisioning
	config.vm.provision :chef_solo do |chef|

		# Configuration
		chef.json = {
			"mysql" => {
				"server_root_password" => "",
				"server_repl_password" => "",
				"server_debian_password" => "",
			}
		}

		# Chef
		chef.cookbooks_path = ".chef/cookbook/"
		chef.data_bags_path = ".chef/databag/"
		chef.roles_path = ".chef/role/"

		# Common
		chef.add_recipe("apt")
		chef.add_recipe("locale")
		chef.add_recipe("cron")
		chef.add_recipe("openssl")
		chef.add_recipe("memcached")
		chef.add_recipe("imagemagick")
		chef.add_recipe("sqlite")
		chef.add_recipe("mysql::server")
		chef.add_recipe("postfix::server")
		#chef.add_recipe("dotdeb")
		#chef.add_recipe("dotdeb::php54")

		# Apache
		chef.add_recipe("apache2")
		chef.add_recipe("apache2::mod_php5")
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
		chef.add_recipe("_box::mod_vhost_alias")

		# PHP
		chef.add_recipe("php")
		chef.add_recipe("php::module_apc")
		chef.add_recipe("php::module_memcache")
		chef.add_recipe("php::module_curl")
		chef.add_recipe("php::module_gd")
		chef.add_recipe("php::module_sqlite3")
		chef.add_recipe("php::module_mysql")

		# Base
		chef.add_recipe("_box")
	end
end

execute "disable-default-site" do
	command "sudo a2dissite default"
end

execute "remove-other-vhosts-access-logs" do
	command "sudo rm -f /etc/apache2/conf.d/other-vhosts-access-log"
end

cookbook_file node['apache']['dir'] + "/conf.d/custom" do
	source "custom.conf"
	mode 00644
	owner "root"
	group node['apache']['root_group']
end

Dir.foreach("/var/www") do |host|
	next if /^(\.|~|_)/.match(host)

	directories = [
		"/var/www/" + host + "/htdocs",
		"/var/www/" + host + "/httpdocs",
		"/var/www/" + host + "/public",
	]

	directories.each { |directory|

		if Dir.exist?(directory)
			web_app host do
				template "host.conf.erb"
				server_name host + ".local"
				docroot directory
				allow_override "All"
			end

			break
		end
	}
end

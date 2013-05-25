execute "disable-default-site" do
	command "sudo a2dissite default"
end

cookbook_file node['apache']['dir'] + "/conf.d/custom" do
	source "custom.conf"
	mode 00644
	owner "root"
	group node['apache']['root_group']
end

Dir.foreach("/vagrant/host") do |host|
	next if /^(\.|~|_)/.match(host)

	directories = [
		"/vagrant/host/" + host + "/htdocs",
		"/vagrant/host/" + host + "/httpdocs",
		"/vagrant/host/" + host + "/public",
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

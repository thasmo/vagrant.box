cookbook_file "/etc/apache2/ssl/server.crt" do
	source "server.crt"
	mode 0777
	owner "root"
	group "root"
end

cookbook_file "/etc/apache2/ssl/server.key" do
	source "server.key"
	mode 0777
	owner "root"
	group "root"
end

execute "disable-default-site" do
	command "sudo a2dissite default"
	notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "hosts" do
	template "host.conf.erb"
	notifies :reload, resources(:service => "apache2"), :delayed
end
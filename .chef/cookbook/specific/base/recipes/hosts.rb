execute "disable-default-site" do
	command "sudo a2dissite default"
	notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "hosts" do
	template "host.conf.erb"
	notifies :reload, resources(:service => "apache2"), :delayed
end

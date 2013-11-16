execute "disable-default-site" do
  command "sudo a2dissite default"
end

execute "remove-other-vhosts-access-logs" do
  command "sudo rm -f /etc/apache2/conf.d/other-vhosts-access-log"
end

execute "remove-all-enabled-sites" do
  command "sudo rm -f /etc/apache2/sites-enabled/*"
end

execute "remove-all-available-sites" do
  command "sudo rm -f /etc/apache2/sites-available/*"
end

cookbook_file node['apache']['dir'] + "/conf.d/custom.conf" do
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
      web_app "1-" + host do
        template "host.conf.erb"
        server_name host + ".local"
        docroot directory
        allow_override "All"
      end

      break
    end
  }

  subdirectory = "/var/www/" + host + "/host"

  if Dir.exist?(subdirectory)
    Dir.foreach(subdirectory) do |subhost|
      next if /^(\.|~|_)/.match(subhost)

      subdirectories = [
        subdirectory + "/" + subhost + "/htdocs",
        subdirectory + "/" + subhost + "/httpdocs",
        subdirectory + "/" + subhost + "/public",
      ]

      subdirectories.each { |directory|

        if Dir.exist?(directory)
          web_app "0-" + subhost + "." + host do
            template "host.conf.erb"
            server_name subhost + "." + host + ".local"
            docroot directory
            allow_override "All"
          end

          break
        end
      }
    end
  end
end

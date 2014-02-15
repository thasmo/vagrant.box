Dir.foreach('/var/www') do |host|
  next if /^(\.|~|_)/.match(host)

  directories = [
    '/var/www/' + host + '/htdocs',
    '/var/www/' + host + '/httpdocs',
    '/var/www/' + host + '/public',
  ]

  directories.each { |directory|

    if Dir.exist?(directory)
      web_app '002-' + host do
        template 'apache/host.conf.erb'
        server_name host + '.' + node['base']['domain']
        docroot directory
        allow_override 'All'
      end

      break
    end
  }

  subdirectory = '/var/www/' + host + '/host'

  if Dir.exist?(subdirectory)
    Dir.foreach(subdirectory) do |subhost|
      next if /^(\.|~|_)/.match(subhost)

      subdirectories = [
        subdirectory + '/' + subhost + '/htdocs',
        subdirectory + '/' + subhost + '/httpdocs',
        subdirectory + '/' + subhost + '/public',
      ]

      subdirectories.each { |directory|

        if Dir.exist?(directory)
          web_app '001-' + subhost + '.' + host do
            template 'apache/host.conf.erb'
            server_name subhost + '.' + host + '.' + node['base']['domain']
            docroot directory
            allow_override 'All'
          end

          break
        end
      }
    end
  end
end

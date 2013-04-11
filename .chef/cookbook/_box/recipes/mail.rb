package "dovecot-postfix" do
  action :install
end

template "/etc/postfix/virtual" do
  source "virtual.erb"
  owner "root"
  group "root"
  mode "0755"
end

ruby_block "configure-virtual-alias-maps-file" do
  block do
    file = Chef::Util::FileEdit.new("/etc/postfix/main.cf")
    file.insert_line_if_no_match(
      "/virtual_alias_maps =/",
      "virtual_alias_maps = regexp:/etc/postfix/virtual"
    )
    file.write_file
  end
end

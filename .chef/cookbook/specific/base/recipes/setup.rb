execute "Change shell to ZSH" do
  command "sudo chsh -s $(which zsh) vagrant"
end

cookbook_file "/etc/php5/conf.d/00-custom.ini" do
  source "php-custom.ini"
  mode 0755
  owner "root"
  group "root"
end

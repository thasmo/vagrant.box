include_recipe "php"

php_pear_channel "pear.phing.info" do
  action :discover
end

php_pear "phing" do
  channel "pear.phing.info"
  action :install
end

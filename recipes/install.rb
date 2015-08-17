#install apache
include_recipe "apache2"
include_recipe "apache2::mod_ssl"
include_recipe "apache2::mod_php5"

#install deps
%w{php-mbstring php-pdo php-mysql php-mcrypt php-pecl-imagick}.each do |pkg|
  package pkg do
    notifies :restart, "service[apache2]", :delayed
  end
end

app_home = node['craft']['app_home']
craft_home = node['craft']['craft_home']
major = node['craft']['install']['version']['major']
minor = node['craft']['install']['version']['minor']
version = "#{major}.#{minor}"
install_url = "#{node['craft']['install']['url']}/#{major}/#{version}/Craft-#{version}.tar.gz"
#setup dirs
directory craft_home do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

#get/extract craft set perms on folders to 744
ark 'craft' do
  url install_url
  path app_home
  checksum node['craft']["#{version}"]
  strip_components 0
  action :put
end

include_recipe 'craft::configure'

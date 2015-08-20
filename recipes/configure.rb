app_home = node['craft']['app_home']
craft_home = node['craft']['craft_home']

%w{app storage config}.each do |dir|
  directory "#{craft_home}/craft/#{dir}" do
    owner "apache"
    group "root"
    mode "0755"
    recursive true
  end
end

#update craft/config/db.php
template "#{craft_home}/craft/config/db.php" do
  source "db.php.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :host => node['craft']['db']['host'] ,
    :user => node['craft']['db']['user'],
    :password => node['craft']['db']['password'],
    :database => node['craft']['db']['database'],
    :prefix => node['craft']['db']['prefix']

  })
  notifies :restart, "service[apache2]", :delayed
end

template "#{craft_home}/craft/config/general.php" do
  source "general.php.erb"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[apache2]", :delayed
  action :create_if_missing
end

if node['craft']['license']
  cookbook_file "#{craft_home}/craft/config/license.key" do
    source  'license.key'
    owner "root"
    group "root"
    mode  "0644"
  end
end

directory "#{craft_home}/public" do
    owner "apache"
    group "root"
    mode "0755"
 end


file "#{craft_home}/public/htaccess" do
  action :delete
end

template "#{craft_home}/public/.htaccess" do
  source "public.htaccess.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/httpd/sites-available/craft.conf" do
  source "apache-site.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :http_port => node['craft']['ports']['http_port'],
    :https_port => node['craft']['ports']['https_port'],
    :docroot =>  "#{craft_home}/public",
    :server_name => node['hostname'],
    :server_aliases => [node['fqdn'], "*"],
    :ssl_crt => node['craft']['cert'],
    :ssl_key => node['craft']['cert'],
    :name => "craft",
    :allow_override => "All"
  })
  notifies :restart, "service[apache2]", :delayed
end

#Generate self signed certs if cert doesn't exist on the file system
if not  ::File.exists?(node['craft']['cert'] )
  bash "gen temp ssl certs for testing" do
    code <<-EOS
        openssl genrsa -out /tmp/tmp.key 4096
        openssl req -subj "/C=US/ST=UT/L=SLC/O=JB/OU=IT/CN=Tester/emailAddress=noreply@jamberry.com" -new -key /tmp/tmp.key -out /tmp/tmp.csr
        openssl x509 -req -days 365 -in /tmp/tmp.csr -signkey /tmp/tmp.key -out /tmp/tmp.crt
        cat /tmp/tmp.{key,crt} >> #{node['craft']['cert']}
        rm -f /tmp/tmp.{csr,key,crt}
        EOS
   if not ::File.exists?(node['craft']['cert'])
     puts "#{node['craft']['cert']}"
   end
  end
end

link "/etc/httpd/sites-enabled/craft.conf" do
 to "/etc/httpd/sites-available/craft.conf"
end


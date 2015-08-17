default['craft']['install']['version']['major'] = '2.4'
default['craft']['install']['version']['minor'] = '2670'
default['craft']['install']['url'] = 'http://download.buildwithcraft.com/craft'
default['craft']['app_home'] = '/opt/jamberry'
default['craft']['craft_home'] = "#{node['craft']['app_home']}/craft"
default['craft']['db']['host'] = 'localhost'
default['craft']['db']['user'] = 'root'
default['craft']['db']['password'] = 'changeme'
default['craft']['db']['database'] = 'craft'
default['craft']['db']['prefix']  = 'craft'
default['craft']['ports']['http_port'] = node["craft_data"]["application_layout"]["http_port"]
default['craft']['ports']['https_port'] = node["craft_data"]["application_layout"]["https_port"]
default['craft']['cert'] = '/etc/httpd/ssl/craft.pem'
default['craft']['license'] = true

default['apache']['listen_ports'] = [ "#{node['craft']['ports']['https_port']}", "#{node['craft']['ports']['http_port']}"]

#version checksums here
default['craft']['2.4.2670'] = 'eb352bc60f4c1cd9beb7c2a24d4250c825b3f60a3dd65f9e34f37b586dc33588'
default['craft']['app_version'] = 'master'

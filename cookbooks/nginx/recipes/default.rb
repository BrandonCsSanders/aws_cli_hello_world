#
# Cookbook Name:: nginx
# Recipe:: default
#

package 'nginx' do
  action :install
end

package 'nginx-common' do
  action :install
end

package 'nginx-core' do
  action :install
end

cookbook_file '/etc/nginx/nginx.conf' do
  source   'nginx.conf'
  owner    'root'
  group    'root'
  mode     0644
  backup   false
  action   :create
  notifies :restart, 'service[nginx]', :delayed
end

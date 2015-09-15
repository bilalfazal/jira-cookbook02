#
# Cookbook Name:: jira-cookbook02
# Recipe:: apache_config
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'httpd'

service 'httpd' do
  action [:enable, :start]
end

template 'ApacheRedirect' do
  source 'httpdConf.erb'
  path '/etc/httpd/conf/httpd.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[httpd]', :immediately
end

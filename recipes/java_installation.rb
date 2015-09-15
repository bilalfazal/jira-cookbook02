#
# Cookbook Name:: jira-cookbook02
# Recipe:: java_installation
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

bash 'JavaInstall_script' do
  code <<-EOH
  ./opt/java_install.sh
  EOH
  action :nothing
end

template 'JavaInstall' do
  source 'java_installation.erb'
  path '/opt/java_install.sh'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :run, 'bash[JavaInstall_script]', :immediately
end

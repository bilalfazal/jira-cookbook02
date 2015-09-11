#
# Cookbook Name:: jira_server02
# Recipe:: apache_install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'httpd'

service 'httpd' do
  action [:enable, :start]
end

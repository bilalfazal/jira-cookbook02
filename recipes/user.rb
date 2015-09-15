#
# Cookbook Name:: jira_server02
# Recipe:: user
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

group node['jira_server02']['application_group']

user node['jira_server02']['application_user'] do
  group node['jira_server02']['application_group']
  home "/home/#{node['jira_server02']['application_user']}"
  # home '/home/jira'
  password 'P@ssword'
  shell '/bin/bash'
end

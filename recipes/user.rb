#
# Cookbook Name:: jira_server02
# Recipe:: user
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

user 'jira' do
  username 'jira'
  home '/home/jira'
  password 'P@ssword'
  shell '/bin/bash'
end

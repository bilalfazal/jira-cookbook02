#
# Cookbook Name:: jira-cookbook02
# Recipe:: iptables_rules
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

template 'iptables_change' do
  source 'iptables_rules.erb'
  path '/etc/sysconfig/iptables'
  owner 'root'
  group 'root'
  mode '0600'
  # notifies :start, 'service[iptables]', :delayed
end

service 'iptables' do
  action :start
end

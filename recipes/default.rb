#
# Cookbook Name:: jira_server02
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'jira_server02::user'
include_recipe 'jira_server02::java_installation'
include_recipe 'jira_server02::apache_install'

template 'iptables_change' do
  source 'iptables_rules.erb'
  path '/etc/sysconfig/iptables'
  owner 'root'
  group 'root'
  mode '0600'
  # notifies :restart, 'service [iptables]', :immediately
  # notifies :restart, 'service[iptables]', :immediately
end

service 'iptables' do
  action :start
end

template 'ApacheRedirect' do
  source 'httpdConf.erb'
  path '/etc/httpd/conf/httpd.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[httpd]', :immediately
end

remote_file '/opt/atlassian-jira-6.4.11.tar.gz' do
  source 'https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-6.4.11.tar.gz'
end

bash 'untarInstall-jira' do
  code <<-EOH
  mkdir /opt/atlassian
  tar -zxvf /opt/atlassian-jira-6.4.11.tar.gz -C /opt/atlassian/
  EOH
  creates '/opt/atlassian/'
end

directory '/jira' do
  owner 'jira'
  group 'jira'
  mode '0755'
end

template 'JiraApplication-Config' do
  source 'jira-application.properties.erb'
  path '/opt/atlassian/atlassian-jira-6.4.11-standalone/atlassian-jira/WEB-INF/classes/jira-application.properties'
  owner 'jira'
  group 'jira'
  action :create
end

bash 'permissions-JIRA' do
  code <<-EOH
  chown -R jira:jira /opt/atlassian
  echo JIRA_HOME = "/jira" >> /etc/environment
  EOH
  not_if 'grep "JIRA_HOME = /jira" /etc/environment'
end

bash 'Run-JIRA' do
  code <<-EOH
  su jira
  #./opt/atlassian/atlassian-jira-6.4.11-standalone/bin/start-jira.sh
  EOH
end

# service '/opt/atlassian/atlassian-jira-6.4.11-standalone/bin/start-jira.sh' do
# action :start
# end

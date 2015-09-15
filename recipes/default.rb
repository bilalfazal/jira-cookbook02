#
# Cookbook Name:: jira_server02
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'jira_server02::user'
# include_recipe 'jira_server02::java_installation'
include_recipe 'jira_server02::apache_install'

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

template 'ApacheRedirect' do
  source 'httpdConf.erb'
  path '/etc/httpd/conf/httpd.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[httpd]', :immediately
end

remote_file '/opt/atlassian-jira-6.4.11.tar.gz' do
  source node['jira_server02']['jira_download_source']
  # source 'https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-6.4.11.tar.gz'
end

bash 'untarInstall-jira' do
  code <<-EOH
  mkdir /opt/atlassian
  tar -zxvf /opt/atlassian-jira-6.4.11.tar.gz -C /opt/atlassian/
  EOH
  creates node['jira_server02']['jira_basepath']
end

directory '/jira' do
  owner node['jira_server02']['application_user']
  group node['jira_server02']['application_group']
  mode '0755'
end

template "#{node['jira_server02']['jira_basepath']}/atlassian-jira/WEB-INF/classes/jira-application.properties" do
  source 'jira-application.properties.erb'
  owner node['jira_server02']['application_user']
  group node['jira_server02']['application_group']
  action :create
end

bash 'permissions-JIRA' do
  code <<-EOH
  chown -R jira:jira "#{node['jira_server02']['jira_basepath']}"
  echo JIRA_HOME = "/jira" >> /etc/environment
  EOH
  not_if 'grep "JIRA_HOME = /jira" /etc/environment'
end

template 'JiraServiceShortcut' do
  source 'jiraServiceShortCut.erb'
  path '/etc/init.d/jira'
  owner 'root'
  group 'root'
  mode '0755'
end

bash 'Run-JIRA' do
  code <<-EOH
  su jira
  service jira start
  EOH
  not_if 'netstat -tulpn | grep java'
end

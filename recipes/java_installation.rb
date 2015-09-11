#
# Cookbook Name:: jira_server02
# Recipe:: java_installation
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

bash 'java-download' do
  code <<-EOH
  cd /opt/
  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz"
  tar -zxvf /opt/jdk-8u60-linux-x64.tar.gz -C /opt/atlassian/
  EOH
  creates '/opt/atlassian/jdk1.8.0_60'
end

bash 'java-install' do
  code <<-EOH
  alternatives --install /usr/bin/java java /opt/atlassian/jdk1.8.0_60/bin/java 2
  alternatives --config java
  alternatives --install /usr/bin/jar jar /opt/atlassian/jdk1.8.0_60/bin/jar 2
  alternatives --install /usr/bin/javac javac /opt/atlassian/jdk1.8.0_60/bin/javac 2
  alternatives --set jar /opt/atlassian/jdk1.8.0_60/bin/jar
  alternatives --set javac /opt/atlassian/jdk1.8.0_60/bin/javac
  EOH
  creates '/usr/bin/java'
end

bash 'SETEnvVAR' do
  code <<-EOH
  echo JAVA_HOME="/opt/atlassian/jdk1.8.0_60" >> /etc/environment
  echo JRE_HOME="/opt/atlassian/jdk1.8.0_60/jre" >> /etc/environment
  echo PATH="$PATH:/opt/atlassian/jdk1.8.0_60:/opt/atlassian/jdk1.8.0_60/jre/bin" >> /etc/environment
  EOH
  not_if 'grep "JAVA_HOME=/opt/atlassian/jdk1.8.0_60" /etc/environment'
end

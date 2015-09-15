require 'spec_helper'

# Check if HTTPD service is enabled and running
describe service('httpd') do
  it { should be_enabled }
  it { should be_running   }
end

# Verify that the VirtualHost 80 config has been successfully appended to the server
describe file('/etc/httpd/conf/httpd.conf') do
  it { should contain 'ProxyPass / http://localhost:8080/ timeout=600' }
end


describe file('/opt/atlassian/atlassian-jira-6.4.11-standalone/atlassian-jira/WEB-INF/classes/jira-application.properties') do
  it { should contain 'jira.home =/jira' }
end

# Verify the successfuly installation of Java
describe command('echo $JAVA_HOME') do
  its(:stdout) { should contain('/opt/atlassian/jdk1.8.0_60') }
end

# Checking Jira service
describe service('jira') do
  it { should be_running }
end

# Verify that the user:jira is assigned permission to the JIRA installation path
describe command('ls -l /opt/atlassian | grep jira') do
  its(:stdout) { should contain('atlassian-jira-6.4.11-standalone') }
end

# A final cURL check on the initial JIRA webpage if its up or not 
describe command('curl -L 192.168.50.10') do
  its(:stdout) { should contain('Set up and configure your JIRA instance') }
  # its(:stdout) { should contain('bilalbilal') }
end

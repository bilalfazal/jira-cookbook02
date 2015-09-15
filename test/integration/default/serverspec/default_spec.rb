require 'spec_helper'

describe service('httpd') do
  it { should be_enabled }
  it { should be_running   }
end

describe file('/etc/httpd/conf/httpd.conf') do
  it { should contain 'ProxyPass / http://localhost:8080/ timeout=600' }
end

describe file('/opt/atlassian/atlassian-jira-6.4.11-standalone/atlassian-jira/WEB-INF/classes/jira-application.properties') do
  it { should contain 'jira.home =/jira' }
end

describe command('echo $JAVA_HOME') do
  its(:stdout) { should contain('/opt/atlassian/jdk1.8.0_60') }
end

describe service('jira') do
  it { should be_running }
end

# describe command('ls -l
describe command('curl -L 192.168.50.10') do
  its(:stdout) { should contain('Set up and configure your JIRA instance') }
  # its(:stdout) { should contain('bilalbilal') }
end

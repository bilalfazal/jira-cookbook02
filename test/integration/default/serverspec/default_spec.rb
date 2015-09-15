require 'spec_helper'

describe service('httpd') do
  it { should be_enabled }
  it { should be_running   }
end

describe service('jira') do
  it { should be_running }
end

describe command('curl -L 192.168.50.10') do
  its(:stdout) { should contain('Set up and configure your JIRA instance') }
  # its(:stdout) { should contain('bilalbilal') }
  'jira is up and running'
  # it { JIRA site is up and running }
end

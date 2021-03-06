#Details

Installs Atlassian Jira Server

##Requirements

* CentOS 6
* ChefDK 0.7.0
* Vagrant/Virtualbox (for Test Kitchen)

##Recipes

* `recipe[jira_server02::default]` Downloads, installs and configures Atlassian JIRA. Includes the below recipes.
* `recipe[jira_server02::java_installation]` Runs a script that downloads and configures JAVA for Jira application including env variables 
* `recipe[jira_server02::apache_config]` Install HTTPD, enables the service, change the httpd file to setup JIRA localhost:8080 to accept incoming requests on port 80.  
* `recipe[jira_server02::iptables_rules]` creates iptables file (under /etc/sysconfig) with the rules and starts the service.

##Integration Testing

Run Test Kitchen with serverspec tests

####Test Kitchen
* Included with ChefDK
* Relies on Vagrant/Virtualbox as the driver. This is a default driver included with ChefDK
* Brings up a VM with a DHCP IP in private space

* $mkdir chef-repo
* $cd chef-repo/
* git clone https://github.com/bilalfazal/jira-cookbook02.git 
* kitchen test
* chef exec rake 

To open the JIRA application:
* get the IP address of the kitchen VM instance
* browse to the VM IP http://#.#.#.#

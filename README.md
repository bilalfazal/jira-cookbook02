#Details

Installs Atlassian Jira Server

##Requirements

* CentOS 6
* ChefDK 0.7.0
* Vagrant/Virtualbox (for Test Kitchen)

##Recipes

* `recipe[jira_server02::default]` Downloads, installs and configures Atlassian JIRA. Includes the below recipes.
* `recipe[jira_server02::java_installation]` Runs a script that downloads and configures JAVA for Jira application including env variables 
* `recipe[jira_server02::apache_config]` Install HTTPD, enables the service, change the httpd file to setup as a port:80 proxy to localhost:8080.  
* `recipe[jira_server02::iptables_rules]` creates iptables file (under /etc/sysconfig) with the rules and starts the sservice.

##Integration Testing

Run Test Kitchen with serverspec tests

#Test Kitchen
* This is included with ChefDK
* Relies on Vagrant/Virtualbox as the driver. This is a default driver included with ChefDK
* Brings up a vagrant VM with IP 192.168.50.10

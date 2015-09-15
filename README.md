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
* `recipe[jira_server02::iptables_rules]` enable port 8080, 443


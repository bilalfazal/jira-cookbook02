#Details

Installs Atlassian Jira Server

##Requirements

* CentOS 6
* ChefDK 0.7.0
* Vagrant/Virtualbox (for Test Kitchen)

##Recipes

* `recipe[jira_server02::default]` Downloads, installs and configures Atlassian JIRA. Includes the below recipes.
* `recipe[jira_server02::java_installation]` 
* `recipe[jira_server02::apache_config]` 
* `recipe[jira_server02::iptables_rules]`


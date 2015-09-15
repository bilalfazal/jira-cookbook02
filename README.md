#Details

Installs Atlassian Jira Server

##Requirements

* CentOS 6
* ChefDK 0.7.0
* Vagrant/Virtualbox (for Test Kitchen)

##Recipes

* `recipe[jira_server02::default]` Downloads, installs and configures Atlassian JIRA. Includes the below recipes.
* `recipe[jira_server02::java_installation]` Installs/configures Apache 2 as proxy (ports 80/443)
* `recipe[jira_server02::apache_config]` Installs/configures MySQL/Postgres server, database, and user for Confluence
* `recipe[jira_server02::iptables_rules]` Installs/configures Confluence via Linux installer"


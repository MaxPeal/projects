#cat /vagrant/toolbox/etc_hosts | sudo tee -a /etc/hosts	
cat "/vagrant/toolbox/etc_hosts.demo" | sudo tee -a /etc/hosts	
#cat "/vagrant/toolbox/etc_hosts" | sudo tee -a /etc/hosts	
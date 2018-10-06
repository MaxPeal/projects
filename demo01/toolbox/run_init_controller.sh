#!/bin/bash
/vagrant/toolbox/run_hosts_update.sh
/vagrant/toolbox/run_link_ansible_demo.sh
/vagrant/toolbox/run_link_toolbox.sh
/vagrant/toolbox/run_ssh_copy_ids.sh
/vagrant/toolbox/../bootstrap_ansible.sh
/vagrant/toolbox/../bootstrap_mkpasswd.sh

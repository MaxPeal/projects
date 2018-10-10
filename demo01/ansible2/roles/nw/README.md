Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

nw_if_update.yml
# Constants
NW_IF_UPDATE_BOND_MODE_LACP=4
# Flags
NW_IF_UPDATE_DHCP_ASSIGNED="dhcp assigned"

# Variables
nw_if_update_interfaces:

- device: <string #infterface name>
  boot_mode: <auto|allow-hotplug>
  bootproto_static: <static|dhcp|manual>
    ipv4
      address: <ip address>
      broadcast: <ip address>
      netmask: <ip address>
      gateway: <ip_address|NW_IF_UPDATE_DHCP_ASSIGNED>
      dns_nameservers:
        - <dhcp ip address #1>  
        - <dhcp ip address #2>
      dns_search:
        - <domain name>
  bootproto_dhcp: <yes|no>
  bootproto_manual: <yes|no>
  vlan:
    vlan_raw_device: <base interface device name>
  bond_slave_lacp:
    bond_master: <bond device name (e.g. bond0)>
  bond_master_lacp:
    bond_slaves:
      - <bond slave device name #1 (e.g. eth0)>
      - <bond slave device name #2 (e.g. eth1)>
    #bond_mode: NW_IF_UPDATE_BOND_MODE_LACP
    #bond_miimon: 100
    #bond_lacp_rate 1
  bridge:
    bridge_ports:
      - <device name #1>
      - <device name #2>
    bridge_stp: <on|off>
    #bridge_hello 2
    #bridge_fd: 9
  post-up:
    - <command statements>
  pre-down:
    - <command statements>

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).

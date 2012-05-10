Deploy.me
=========

In Soviet Russia Cloud deploys you.

Handy OpenStack installation kit on top of chef, devstack and github.com/mkorenkov/wheel

Installation instructions
-------------------------

    curl https://raw.github.com/OpenStack-Kha/deployme/master/run.sh | bash -s deploy head node at ningbo

where `head` is a json config file with roles run list.

Change config files on different hosts
--------------------------------------

    curl https://raw.github.com/OpenStack-Kha/deployme/master/change_ini.sh | bash -s localhost /etc/nova/nova.conf default vlan_interface eth1

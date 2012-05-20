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

    curl https://raw.github.com/OpenStack-Kha/deployme/master/change_ini.sh | bash -s localhost /etc/nova/nova.conf DEFAULT vlan_interface eth1
    curl https://raw.github.com/OpenStack-Kha/deployme/master/change_ini.sh | bash -s 21-26,21-27,21-28,21-29,21-30,21-32,21-33,21-34,21-35 /etc/nova/nova.conf DEFAULT use_single_default_gateway True

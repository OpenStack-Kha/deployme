# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :openstack do |os_config|
        os_config.vm.network :hostonly, "10.100.0.101", :netmask => "255.255.0.0"
        os_config.vm.host_name = "os-main"
        os_config.vm.box = "os-oneiric"
        os_config.vm.forward_port 22, 2224
        os_config.vm.forward_port 80, 8081
        os_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = "cookbooks"
            chef.add_recipe "wheel::stack"
            chef.add_recipe "wheel::tempest"
            chef.log_level = :debug
        end 
    end
end


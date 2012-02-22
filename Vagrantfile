# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :openstack do |os_config|
        os_config.vm.network :hostonly, "10.0.0.101", :netmask => "255.255.255.0"
        os_config.vm.host_name = "os-main"
        os_config.vm.box = "os-oneiric"
        os_config.vm.forward_port 22, 2224
        os_config.vm.forward_port 80, 8081
        os_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = "cookbooks"
            chef.add_recipe "wheel::stack"
            chef.log_level = :debug
        end 
    end
    config.vm.define :rabbit do |rabbit_config|
        rabbit_config.vm.network :hostonly, "10.0.0.102", :netmask => "255.255.255.0"
        rabbit_config.vm.host_name = "os-main"
        rabbit_config.vm.box = "os-oneiric"
        rabbit_config.vm.forward_port 22, 2225
        rabbit_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = "cookbooks"
            chef.add_recipe "wheel::rabbitmq"
            chef.log_level = :debug
        end 
    end
end


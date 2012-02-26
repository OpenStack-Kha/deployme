# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :openstack do |os_config|
        os_config.vm.network :bridged
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
        rabbit_config.vm.network :bridged
        rabbit_config.vm.host_name = "os-rabbit"
        rabbit_config.vm.box = "os-oneiric"
        rabbit_config.vm.forward_port 22, 2225
        rabbit_config.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = "cookbooks"
            chef.add_recipe "wheel::rabbitmq"
            chef.log_level = :debug
        end 
    end
    config.vm.define :rabbit2 do |rabbit_config2|
        rabbit_config2.vm.network :bridged
        rabbit_config2.vm.host_name = "os-rabbit2"
        rabbit_config2.vm.box = "os-oneiric"
        rabbit_config2.vm.forward_port 22, 2226
        rabbit_config2.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = "cookbooks"
            chef.add_recipe "wheel::rabbitmq"
            chef.log_level = :debug
        end 
    end
end


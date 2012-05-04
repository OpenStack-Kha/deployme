# -*- mode: ruby -*-
# # vi: set ft=ruby :
#
# Cookbook Name:: wheel
# Recipe:: stack 
#

include_recipe "wheel::prestack"

Chef::Log.info("started recipe stack")
Chef::Log.debug("enabled services: #{node[:stack][:enabled_services]}")

execute "sudo ./stack_centos.sh" do
    environment ({"HOME" => "/home/#{node[:wheel][:username]}"})
    cwd "/tmp/#{node[:wheel][:username]}/devstack"
    not_if {File.exists?("/opt/stack/devstack")}
end


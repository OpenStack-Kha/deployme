# -*- mode: ruby -*-
# # vi: set ft=ruby :
#
# Cookbook Name:: wheel
# Recipe:: stack 
#

include_recipe "wheel::prestack"

Chef::Log.info("started recipe stack")

execute "sudo ./stack.sh" do
    environment ({"HOME" => "/home/#{node[:wheel][:username]}"})
    cwd "/home/#{node[:wheel][:username]}/devstack"
    not_if {File.exists?("/opt/stack/devstack")}
end


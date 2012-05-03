# -*- mode: ruby -*-
# # vi: set ft=ruby :
#
# Cookbook Name:: wheel
# Recipe:: prestack 
#

include_recipe "git::default"

# fixes CHEF-1699
ruby_block "reset group list" do
    block do
        Etc.endgrent
    end                
    action :nothing
end

Chef::Log.info("started recipe prestack")

Chef::Log.debug("User #{node[:wheel][:username]}")
user node[:wheel][:username] do
    comment "Wheel User"
    home "/home/#{node[:wheel][:username]}"
    shell "/bin/bash"
    notifies :create, "ruby_block[reset group list]", :immediately
end

directory "/home/#{node[:wheel][:username]}" do
    owner node[:wheel][:username]
    group node[:wheel][:username]
    mode "0755"
    action :create
end

directory "/home/#{node[:wheel][:username]}/.ssh" do
    owner node[:wheel][:username]
    group node[:wheel][:username]
    mode "0755"
    action :create
end

cookbook_file "/home/#{node[:wheel][:username]}/.ssh/config" do
    source "config"
    owner node[:wheel][:username]
    group node[:wheel][:username]
    action :create_if_missing
end

cookbook_file "/home/#{node[:wheel][:username]}/.ssh/id_rsa" do
    source "id_rsa"
    owner node[:wheel][:username]
    group node[:wheel][:username]
    mode "0600"
    action :create_if_missing
end

cookbook_file "/home/#{node[:wheel][:username]}/.ssh/id_rsa.pub" do
    source "id_rsa.pub"
    owner node[:wheel][:username]
    group node[:wheel][:username]
    action :create_if_missing
end

git "/home/#{node[:wheel][:username]}/devstack" do
    repository node[:stack][:repository_url]
    reference "#{node[:stack][:branch]}"
    action :sync
    user node[:wheel][:username]
end

template "/home/#{node[:wheel][:username]}/devstack/localrc" do
    source "localrc.erb"
    owner node[:wheel][:username]
    group node[:wheel][:username]
    action :create_if_missing
    variables(
        :SERVICE_TOKEN => node[:stack][:service_token],
        :ADMIN_PASSWORD => node[:stack][:admin_password],
        :GUEST_PASSWORD => node[:stack][:guest_password],
        :ENABLED_SERVICES => node[:stack][:enabled_services],
        :PUBLIC_INTERFACE => node[:stack][:public_interface],
        :VLAN_INTERFACE => node[:stack][:vlan_interface],
        :MULTI_HOST => node[:stack][:multi_host],
        :GLANCE_HOSTPORT => node[:stack][:glance_hostport],
        :KEYSTONE_API_PORT => node[:stack][:keystone][:api_port],
        :KEYSTONE_AUTH_HOST => node[:stack][:keystone][:auth_host],
        :KEYSTONE_AUTH_PORT => node[:stack][:keystone][:auth_port],
        :KEYSTONE_AUTH_PROTOCOL => node[:stack][:keystone][:auth_protocol],
        :KEYSTONE_SERVICE_HOST => node[:stack][:keystone][:service_host],
        :KEYSTONE_SERVICE_PORT => node[:stack][:keystone][:service_port],
        :KEYSTONE_SERVICE_PROTOCOL => node[:stack][:keystone][:service_protocol],
        :LIBVIRT_TYPE => node[:stack][:libvirt_type],
        :MYSQL_HOST => node[:stack][:mysql][:host],
        :MYSQL_USER => node[:stack][:mysql][:user],
        :MYSQL_PASSWORD => node[:stack][:mysql][:password],
        :RABBIT_HOST => node[:stack][:rabbit][:host],
        :RABBIT_PASSWORD => node[:stack][:rabbit][:password],
        :REPOS => node[:stack][:repos],
        :DEVSTACK_BRANCH => node[:stack][:branch],
        :BRANCHES => node[:stack][:branches]        
    )
end


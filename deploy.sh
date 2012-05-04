#!/bin/bash

#install the RBEL repo
rpm -Uvh http://rbel.frameos.org/rbel6
#install Ruby and other development tools:
yum -y install ruby ruby-devel ruby-ri ruby-rdoc ruby-shadow gcc gcc-c++ automake autoconf make curl dmidecode
#install RubyGems from Source
cd /tmp
curl -O http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz
tar zxf rubygems-1.8.10.tgz
ruby rubygems-1.8.10/setup.rb --no-format-executable
cd -
#install Chef Gem
gem install chef --no-ri --no-rdoc

# clone deployme repo
git clone https://github.com/OpenStack-Kha/deployme.git /tmp/deployme && cd /tmp/deployme

# run, Forest, run!
chef-solo -c config/solo.rb -j config/$1.json


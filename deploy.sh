#!/bin/bash

## usage:
# ./run.sh deploy head node at ningbo

if [ $# -ne 5 ]
then
  echo "Usage: run.sh deploy [role] node at [config_branch]"
  echo "e.g. run.sh deploy head node at ningbo"
  exit 1
fi

ROLE=$2
BRANCH=$5
RUBYGEMS={$RUBYGEMS:-rubygems-1.8.10}
DEPLOYME={$DEPLOYME:-https://github.com/OpenStack-Kha/deployme.git}
DEPLOYME_CONFIG={$DEPLOYME_CONFIG:-https://github.com/OpenStack-Kha/deployme.config.git}

rm -rf /tmp/deployme

#install the RBEL repo
rpm -Uvh http://rbel.frameos.org/rbel6
#install Ruby and other development tools:
yum -y install ruby ruby-devel ruby-ri ruby-rdoc ruby-shadow gcc gcc-c++ automake autoconf make curl dmidecode
#install RubyGems from Source
cd /tmp
curl -O http://production.cf.rubygems.org/rubygems/$RUBYGEMS.tgz
tar zxf $RUBYGEMS.tgz
ruby $RUBYGEMS/setup.rb --no-format-executable
cd -
#install Chef Gem
gem install chef --no-ri --no-rdoc

# clone deployme repo
git clone $DEPLOYME /tmp/deployme && cd /tmp/deployme

# run list
touch config/run.json
echo "{ \"run_list\": \"role[$ROLE]\" }" > config/run.json

#clone roles
git clone $DEPLOYME_CONFIG -b $BRANCH roles

# run, Forest, run!
chef-solo -c config/solo.rb -j config/run.json


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
RUBYGEMS=${RUBYGEMS:-"rubygems-1.8.10"}
DEPLOYME=${DEPLOYME:-"https://github.com/OpenStack-Kha/deployme.git"}
DEPLOYME_CONFIG=${DEPLOYME_CONFIG:-"https://github.com/OpenStack-Kha/deployme.config.git"}
TARGET_DIR=${TARGET_DIR:-"/tmp/deployme"}

rm -rf /tmp/deployme

echo "FYI: installing the RBEL repo"
rpm -Uvh http://rbel.frameos.org/rbel6
echo "FYI: installing ruby and other development tools"
yum -y install ruby ruby-devel ruby-ri ruby-rdoc ruby-shadow gcc gcc-c++ automake autoconf make curl dmidecode
echo "FYI: installing rubyrems from rource"
cd /tmp
curl -O http://production.cf.rubygems.org/rubygems/$RUBYGEMS.tgz
tar zxf $RUBYGEMS.tgz
ruby $RUBYGEMS/setup.rb --no-format-executable
cd -

echo "FYI: installing chef"
#install Chef Gem
gem install chef --no-ri --no-rdoc

# clone deployme repo
echo "FYI: git clone $DEPLOYME $TARGET_DIR"
git clone $DEPLOYME $TARGET_DIR 

# run list
touch $TARGET_DIR/run.json
echo "{ \"run_list\": \"role[$ROLE]\" }" > $TARGET_DIR/run.json

#clone roles
echo "FYI: git clone $DEPLOYME_CONFIG -b $BRANCH $TARGET_DIR/config"
git clone $DEPLOYME_CONFIG -b $BRANCH $TARGET_DIR/config

# run, Forest, run!
echo "FYI: chef-solo -c $TARGET_DIR/solo.cfg.rb -j $TARGET_DIR/run.json"
cd $TARGET_DIR && chef-solo -c $TARGET_DIR/solo.cfg.rb -j $TARGET_DIR/run.json && cd -


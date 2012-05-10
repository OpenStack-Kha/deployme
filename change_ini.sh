#!/bin/bash

## usage:
# ./change_ini.sh hosts filePath section option value

if [ $# -ne 5 ]
then
  echo "change_ini.sh hosts filePath section option value"
  exit 1
fi

HOSTS=$1
INI_FILE=$2
SECTION=$3
OPTION=$4
VALUE=$5

TARGET_DIR=/tmp/cahnge_ini
DEPLOYME=${DEPLOYME:-"https://github.com/OpenStack-Kha/deployme.git"}

rm -rf $TARGET_DIR

# clone deployme repo
echo "FYI: git clone $DEPLOYME $TARGET_DIR"
git clone $DEPLOYME $TARGET_DIR 

cd $TARGET_DIR
echo "FYI: creating venv"
virtualenv --no-site-packages fab
. fab/bin/activate

echo "FYI: installing fabric"
pip install fabric

echo "FYI: executing fabric"
pwd
echo "FYI: fab -H $HOSTS change_ini_value:$INI_FILE,$SECTION,$OPTION,$VALUE"
fab -H $HOSTS change_ini_value:$INI_FILE,$SECTION,$OPTION,$VALUE

echo "FYI: deactivating venv"
deactivate

cd -

#!/bin/sh

username=$(cat .basic_credentials | awk '{split($0,a,":"); print a[1]}')
password=$(cat .basic_credentials | awk '{split($0,a,":"); print a[2]}')

/home/vsoagent/runtime/node/bin/node agent/vsoagent.js -u $username -p $password -b true -s $SERVER_URL -l $POOL_NAME -a $AGENT_NAME

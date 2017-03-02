#!/bin/bash

echo "In case of errors, use with sudo"

if [ $# -lt 1 ] ; then
  echo "Please specify a compose file to use"
  exit
fi

## Preparations for the logger container
mkdir -p /data/maintenance/log
chmod -R 777 /data/maintenance/log

chown -R 8983:8983 ../solrserver-config/solr-*
docker-compose -f docker-compose.yml -f $1 up -d mongodb solr

sleep 10s # Wait for MongoDB to initialize

docker exec $(docker ps -f name=mongodb* -q) mongo --eval 'config = { _id : "rs0", "members" : [ {_id : 0, "host" : "localhost:27017"} ] }; rs.initiate(config);'
docker exec $(docker ps -f name=mongodb* -q) chown -R 8983:8983 /solr-data/

##Preparation for the userservice
if [ -d ./userservice ]; then
  cp -r userservice /data/
else
  echo "/////////////////////"
  echo "Remember to copy the config files for the userservice"
  echo "in /data/userservice"
  mkdir -p /data/userservice
fi

echo
echo 'For further commands, use:'
echo
echo "docker-compose -f docker-compose.yml -f $1 [options] [COMMAND] [ARGS]"
echo
echo "Execute next: docker-compose -f docker-compose.yml -f $1 up -d"

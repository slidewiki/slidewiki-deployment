#!/bin/bash

echo "In case of errors, use with sudo"

if [ $# -lt 1 ] ; then
  echo "Please specify a compose file to use"
  exit
fi

chown -R 8983:8983 solrserver-config/solr-*
#docker-compose -f $1 pull
docker-compose -f $1 up -d mongodb
sleep 10s
docker exec $(docker ps -f name=mongodb* -q) mongo --eval 'config = { _id : "rs0", "members" : [ {_id : 0, "host" : "localhost:27017"} ] }; rs.initiate(config);'

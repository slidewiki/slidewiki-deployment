#!/bin/bash

PRJ=$(cat instance_name)
PROTO=$(cat protocol)

docker-compose -p $PRJ -f docker-compose.v1.yml  up -d mongodb solr
sleep 3
docker exec $(docker ps -f name=$PRJ\_mongodb_1 -q) mongo --eval 'config = { _id : "rs0", "members" : [ {_id : 0, "host" : "localhost:27017"} ] }; rs.initiate(config);'
docker-compose -p $PRJ -f docker-compose.v1.yml  up -d

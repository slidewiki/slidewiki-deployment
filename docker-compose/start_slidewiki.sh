#!/bin/bash

PRJ=$(cat instance_name)

docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.testing.https.yml  up -d logger
sleep 1
docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.testing.https.yml  up -d mongodb solr
sleep 3
docker exec $(docker ps -f name=$PRJ\_mongodb_1 -q) mongo --eval 'config = { _id : "rs0", "members" : [ {_id : 0, "host" : "localhost:27017"} ] }; rs.initiate(config);'
docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.testing.https.yml  up -d

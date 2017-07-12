#!/bin/bash

PRJ=$1

docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.production.https.yml  up -d logger
sleep 1
docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.production.https.yml  up -d mongodb solr
sleep 3
docker exec $(docker ps -f name=mongodb* -q) mongo --eval 'config = { _id : "rs0", "members" : [ {_id : 0, "host" : "localhost:27017"} ] }; rs.initiate(config);'
docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.production.https.yml  up -d

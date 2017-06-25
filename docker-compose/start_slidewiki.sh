#!/bin/bash

PRJ=$1

docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.testing.https.yml  up -d logger
docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.testing.https.yml  up -d mongodb
docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.testing.https.yml  up -d solr
sleep 2
docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.testing.https.yml  up -d

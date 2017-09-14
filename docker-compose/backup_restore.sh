#!/bin/bash

SOURCE_URL=$1
BACKUPDATE_DATE=$2
INSTANCE_NAME=$(cat instance_name)

# pull latest database dump from stable
curl -u dev:killywilly https://maintenance.$SOURCE_URL/db/slidewiki.mongodump.$BACKUP_DATE.archive.gz > /data/docker/volumes/$INSTANCE_NAME\_mongo-data/_data/dump/mongodump.archive.gz 

# load database dump
docker exec -it $INSTANCE_NAME\_mongodb_1 mongorestore --drop --gzip --archive=/data/db/dump/mongodump.archive.gz

# clean up
rm /data/docker/volumes/$INSTANCE_NAME\_mongo-data/_data/dump/mongodump.archive.gz


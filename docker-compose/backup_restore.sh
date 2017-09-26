#!/bin/bash

cp 1 > /data/docker/volumes/$INSTANCE_NAME\_mongo-data/_data/dump/mongodump.archive.gz
docker exec -it $INSTANCE_NAME\_mongodb_1 mongorestore --drop --gzip --archive=/data/db/dump/mongodump.archive.gz
rm /data/docker/volumes/$INSTANCE_NAME\_mongo-data/_data/dump/mongodump.archive.gz

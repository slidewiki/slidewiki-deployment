#!/bin/bash

PRJ=$(cat instance_name)
BACKUP_DATE=$(date +'%F')

docker exec $(docker ps -f name=$PRJ\_mongodb_1 -q) mongodump --db slidewiki --gzip --archive=/backup/slidewiki.mongodump.$BACKUP_DATE.archive.gz

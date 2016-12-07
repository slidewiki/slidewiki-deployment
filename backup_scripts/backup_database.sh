#!/bin/bash

TEMP_PATH=/tmp/backup
VOLUME_PATH_DB=/data/docker/volumes/database/_data/dump
CONTAINER_PATH_DB=/data/db/dump
VOLUME_PATH_FILES=/data/docker/volumes/files/
BACKUP_DATE=$(date +%F)

mkdir -p $TEMP_PATH/db
mkdir -p $TEMP_PATH/files
 

echo "Creating dump from slidewiki database"
echo ""
docker exec mongodb mongodump -o $CONTAINER_PATH_DB/slidewiki
tar --gzip -cvf $TEMP_PATH/db/slidewiki.mongodump.$BACKUP_DATE.tar.gz -C $VOLUME_PATH_DB/slidewiki/ slidewiki
mv $TEMP_PATH/db/slidewiki.mongodump.$BACKUP_DATE.tar.gz /data/maintenance/db
echo ""

echo "Backing up files"
echo ""
tar -cvf $TEMP_PATH/files/files.$BACKUP_DATE.tar -C $VOLUME_PATH_FILES _data
rm -f /data/maintenance/files/*
mv $TEMP_PATH/files/files.$BACKUP_DATE.tar /data/maintenance/files

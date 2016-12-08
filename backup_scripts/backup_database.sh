#!/bin/bash

BACKUP_DATE=$(date +%F)

mkdir -p /data/maintenance/db
mkdir -p /data/maintenance/files

echo "Creating dump from slidewiki database"
echo ""
mongodump --host mongodb:27017 --db slidewiki --gzip --archive /maintenance/db/slidewiki.mongodump.$BACKUP_DATE.archive.gz
#tar --gzip -cvf /data/maintenance/db/slidewiki.mongodump.$BACKUP_DATE.tar.gz -C /tmp/slidewiki/ slidewiki
echo ""

echo "Backing up files"
echo ""
tar -cvf /maintenance/files/files.$BACKUP_DATE.tar -C /data files

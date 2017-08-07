#!/bin/bash

BACKUP_DATE=$(date +%F)
TO_REMOVE=$(date --date="-5 days" +'%F')

mkdir -p /maintenance/db
#mkdir -p /maintenance/files

echo "Creating dump from slidewiki database"
echo ""
mongodump --host mongodb:27017 --db slidewiki --gzip --archive=/maintenance/db/slidewiki.mongodump.$BACKUP_DATE.archive.gz
echo ""

#echo "Backing up files"
#echo ""
#rm -f /maintenance/files/files.$TO_REMOVE.tar.gz
#tar --gzip -cvf /maintenance/files/files.$BACKUP_DATE.tar.gz -C /data files

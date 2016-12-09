#!/bin/bash

BACKUP_DATE=$(date +%F)

mkdir -p /maintenance/db
mkdir -p /maintenance/files

echo "Creating dump from slidewiki database" >> /var/log/cron.log 2>&1
echo "" >> /var/log/cron.log 2>&1
mongodump --host mongodb:27017 --db slidewiki --gzip --archive=/maintenance/db/slidewiki.mongodump.$BACKUP_DATE.archive.gz >> /var/log/cron.log 2>&1
echo "" >> /var/log/cron.log 2>&1

echo "Backing up files" >> /var/log/cron.log 2>&1
echo "" >> /var/log/cron.log 2>&1
tar --gzip -cvf /maintenance/files/files.$BACKUP_DATE.tar.gz -C /data files >> /var/log/cron.log 2>&1

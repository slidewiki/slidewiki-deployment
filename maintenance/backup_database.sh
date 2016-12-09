#!/bin/bash

BACKUP_DATE=$(date +%F)

mkdir -p /maintenance/db
mkdir -p /maintenance/files

echo "Creating dump from slidewiki database" >> /var/log/cron.log
echo "" >> /var/log/cron.log
mongodump --host mongodb:27017 --db slidewiki --gzip --archive=/maintenance/db/slidewiki.mongodump.$BACKUP_DATE.archive.gz >> /var/log/cron.log
#tar --gzip -cvf /data/maintenance/db/slidewiki.mongodump.$BACKUP_DATE.tar.gz -C /tmp/slidewiki/ slidewiki
echo "" >> /var/log/cron.log

echo "Backing up files" >> /var/log/cron.log
echo "" >> /var/log/cron.log
tar -cvf /maintenance/files/files.$BACKUP_DATE.tar -C /data files >> /var/log/cron.log

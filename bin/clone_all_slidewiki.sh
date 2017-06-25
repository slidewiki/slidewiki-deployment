#!/bin/bash

mkdir /opt/slidewiki
cd /opt/slidewiki
git clone --recursive https://github.com/slidewiki/slidewiki-platform
git clone https://github.com/slidewiki/deck-service
git clone https://github.com/slidewiki/activities-service
git clone https://github.com/slidewiki/discussion-service
git clone https://github.com/slidewiki/notification-service
git clone https://github.com/slidewiki/import-service
git clone https://github.com/slidewiki/user-service
git clone https://github.com/slidewiki/PDF-Service
git clone https://github.com/slidewiki/file-service
git clone https://github.com/slidewiki/search-service
git clone https://github.com/slidewiki/tag-service
git clone https://github.com/slidewiki/nlp-store-service


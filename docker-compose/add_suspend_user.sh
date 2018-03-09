#!/bin/bash

docker exec slidewiki_mongodb_1 mongo slidewiki --eval "db.useridsforsuspension.insertOne({ \"_id\" : $1});"

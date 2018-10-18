#!/bin/bash

PRJ=$(cat instance_name)

docker exec $PRJ\_nlpindexer_1 /nodeApp/bin/delete
docker exec $PRJ\_nlpindexer_1 /nodeApp/bin/deleteJobs
docker exec $PRJ\_nlpindexer_1 /nodeApp/bin/scheduleJobs

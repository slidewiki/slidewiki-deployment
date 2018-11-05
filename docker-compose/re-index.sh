#!/bin/bash

PRJ=$(cat instance_name)

docker exec -t $PRJ\_searchindexer_1 /nodeApp/bin/delete
docker exec -t $PRJ\_searchindexer_1 /nodeApp/bin/index

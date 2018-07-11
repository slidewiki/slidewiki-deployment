#!/bin/bash

PRJ=$(cat instance_name)

docker exec $PRJ\_searchindexer_1 /nodeApp/bin/delete
docker exec $PRJ\_searchindexer_1 /nodeApp/bin/index

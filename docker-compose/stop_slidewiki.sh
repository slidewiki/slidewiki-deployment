#!/bin/bash

PRJ=$(cat instance_name)
PROTO=$(cat protocol)

docker-compose -p $PRJ -f docker-compose.v1.yml down

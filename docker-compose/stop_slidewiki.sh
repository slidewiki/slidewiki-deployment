#!/bin/bash

PRJ=$(cat instance_name)
PROTO=$(cat protocol)

docker-compose -p $PRJ -f docker-compose.yml -f docker-compose.production.$PROTO.yml down

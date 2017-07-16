#!/bin/bash

PRJ=$(cat instance_name)

docker exec $PRJ\_webserver_1 maintenance $1

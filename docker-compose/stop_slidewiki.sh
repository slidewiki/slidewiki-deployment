#!/bin/bash

docker-compose -p $1 -f docker-compose.yml -f docker-compose.testing.https.yml down

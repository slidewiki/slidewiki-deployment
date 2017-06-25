#!/bin/bash

LOGFILE=$(ls -tp /data/maintenance/log/$1/ | grep -v /$ | head -1)
tail -f /data/maintenance/log/$1/$LOGFILE

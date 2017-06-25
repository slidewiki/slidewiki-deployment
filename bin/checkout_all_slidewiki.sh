#!/bin/bash

#cd /opt/slidewiki
for DIR in /opt/slidewiki/*; do
    echo ${DIR}
    if [ -d "${DIR}" ]; then
     cd ${DIR}
     git checkout $1
    fi
done

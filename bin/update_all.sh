#!/bin/bash

WD=/opt/slidewiki

cd $WD
for i in $(ls -1); do
  if [ -d $i ]; then
    cd $i
    echo "Updating: " $i
    git pull
    for SUB in $(git submodule | awk '{print $2}'); do
      cd $SUB
      echo "Updating submodule: " $SUB
      git pull
    done
    cd $WD
  fi
done

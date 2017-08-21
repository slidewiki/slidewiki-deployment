#!/bin/bash

echo "Now creating MongoDB indexes!"

read -r -d '' commands << EOM
use slidewiki;
db.users.createIndex({username: 1});
db.users.createIndex({email: 1, password: 1});
EOM

echo "$commands" | docker exec -i mongotest mongo

echo "Indexes created."

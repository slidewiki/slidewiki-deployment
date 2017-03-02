#!/bin/bash

curl -s https://api.github.com/orgs/slidewiki/repos\?per_page\=200 | perl -ne 'print "$1\n" if (/"clone_url": "([^"]+)/)' | xargs -n 1 git clone --recursive

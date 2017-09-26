# SlideWiki Deployment

This repository is a collection of tools used to run the SlideWiki microservice setup. 

## `/bin`

This directory holds scripts for handling the SlideWiki Git repositories.

## `/docker-compose`

This directory holds docker-compose files, configrations and script for running SlideWiki in a production deployment. See the README included for information about configuring and handling a deployment.

## `/maintenace`

This directory hold the source code for the maintenance image. A docker image that pulls backups from SlideWiki and serves the backups and log files via HTTP.

# Docker-Compose based deployment scripts

by executing the prepare script with a docker-compose file, a deployment is prepared. Executing subsequently `docker-compose build && docker-compose up -d` with the right docker-compose file (use `-f file` option), docker will setup the whole platform on the host system with the corresponding URLs and optiones, specified in docker-compose.yml.

For concrete deplyoment configurations of the different environemtns, see the appropriate docker-compose files.

## Container specific remarks

### User-Service

The deployment of the User-Service needs a configuration file for the social providers, like the example file in this folder. Otherwise it won't start.
The README of the User-Service describes the structure and content of such a file: [User-Service Readme](https://github.com/slidewiki/user-service/blob/master/README.md)

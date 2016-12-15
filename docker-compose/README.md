# Docker-Compose based deployment scripts

by executing the prepare script with a docker-compose file, a deployment is prepared. Executing subsequently `docker-compose build && docker-compose up -d` with the right docker-compose file (use `-f file` option), docker will setup the whole platform on the host system with the corresponding URLs and optiones, specified in docker-compose.yml.

There is currently no way to exchange the specified URLs in slidewiki/platform, so you have to modify these manually. Without modifying these, slidewiki/platform will not work. --> This will be fixed in the future

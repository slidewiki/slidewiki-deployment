# Docker-Compose based deployment scripts

by executing `docker-compose up -d`, docker will setup the whole platform on your local system with the corresponding URLs, specified in docker-compose.yml. There is currently no way to exchange the specified URLs in slidewiki/platform, so you have to modify these manually. Without modifying these, slidewiki/platform will not work.

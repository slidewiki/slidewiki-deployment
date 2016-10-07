# Docker-Compose based deployment scripts

This folder covers another approach to describe the different environments by using overriding docker-compose files. By default, `docker-compose up -d` will start the merge of `docker-compose.yml` and `docker-compose.override.yml`. You can inspect the resulting merge by executing `docker-compose config`. This setup will start the software **localhost mode**.

To work with another environment, execute it like `docker-compose -f docker-compose.yml -f docker-compose.EXTENSION.yml [COMMAND]` and use the shell script `prepare.sh` in addition.

For further documentation, see [Docker Extends - https://docs.docker.com/compose/extends/](https://docs.docker.com/compose/extends/)

FROM mongo:latest
MAINTAINER The SlideWiki Project <dev@slidewiki.org>

RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN apt-get install -y cron
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g http-server

Add ./backup_database.sh /etc/cron.daily/

RUN mkdir /maintenance
WORKDIR /maintenance

EXPOSE 80

Entrypoint []
CMD cron && http-server -p 80 -i

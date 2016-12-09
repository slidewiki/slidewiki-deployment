FROM mongo:latest
MAINTAINER The SlideWiki Project <dev@slidewiki.org>

RUN apt-get update
RUN apt-get install -y nodejs npm cron supervisor
RUN npm install -g http-server
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN mkdir -p /var/log/supervisor && touch /var/log/cron.log

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/simple-cron
ADD backup_database.sh /backup.sh

RUN chmod +x /backup.sh && chmod 0644 /etc/cron.d/simple-cron

RUN mkdir /maintenance
WORKDIR /maintenance

EXPOSE 80
Entrypoint []
CMD supervisord

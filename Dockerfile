FROM alpine:edge
MAINTAINER Grzegorz Wiciak <grzegorz@wiciak.com>

# Setup timezone
RUN apk add --update tzdata && rm -rf /var/cache/apk/*
RUN cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
RUN echo "Europe/Warsaw" >  /etc/timezone
RUN apk del tzdata

# Install bash && database client
RUN apk add --update bash postgresql && rm -rf /var/cache/apk/*

# Add script to container
COPY ./scripts /cron/scripts
RUN chmod -R +x /cron/scripts

# Setup cron tasks
COPY ./crontab /etc/crontabs/root
# Set proper permissions for crontab
RUN chmod 600 /etc/crontabs/root

# Run the command on container startup
CMD ["crond", "-f"]

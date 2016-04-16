FROM ubuntu:xenial
MAINTAINER Grzegorz Wiciak <grzegorz@wiciak.com>

# Setup timezone
RUN ln -sf /usr/share/zoneinfo/CET /etc/localtime

# Install cron
RUN apt-get update && apt-get install -y cron

# Add some useful software
RUN apt-get update && apt-get install -y wget
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > \
  /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add -
RUN apt-get update && apt-get install -y postgresql-client-9.5

# Add script to container
COPY ./scripts /cron/scripts
RUN chmod -R +x /cron/scripts

# Setup cron tasks
COPY ./crontab /etc/crontab
# Set proper permissions for crontab
RUN chmod 600 /etc/crontab

# Run the command on container startup
CMD ["cron", "-f"]

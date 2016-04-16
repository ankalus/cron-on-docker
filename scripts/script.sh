#!/bin/bash
# Dump whole postgres database

DUMP_DIR="/cron/dumps/"
DUMP_PATH=$DUMP_DIR$(date +"%Y-%m-%d-dump.sql")

if [ ! -f $DUMP_PATH ]; then
  # Setup database access
  export PGPASSWORD=mysecretpassword
  export PGHOST=db
  export PGUSER=postgres
  export PGDATABASE=postgres

  pg_dumpall > $DUMP_PATH
  if [ $? -eq 0 ]; then
    echo "pg_dumpall in:" $DUMP_PATH
  else
    rm -f $DUMP_PATH
  fi
else
  echo "found:" $DUMP_PATH
fi

#!/bin/bash

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
FILENAME=$(date +%s) 

echo "Backup Start @" $(date -d @$FILENAME)

/dynamodump.py -m backup -a tar -s "$DYNAMODB_TABLE" -b "$S3_BUCKET" -r "$AWS_DEFAULT_REGION" --dumpPath "$FILENAME" --log INFO >> /var/log/cron.log 2>&1 && rm -rf $FILENAME $FILENAME.tar.bz2


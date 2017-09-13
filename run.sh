#!/bin/bash

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
FILENAME=$(date +%s) 

echo "Backup Start @" $(date -d @$FILENAME)

/dynamodump.py -m backup -a tar -s "$DYNAMODB_TABLE" -b "$S3_BUCKET" -r "$AWS_DEFAULT_REGION" --dumpPath "$FILENAME" --log INFO >> /var/log/cron.log 2>&1 && rm -rf $FILENAME $FILENAME.tar.bz2


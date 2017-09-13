FROM python:2

ENV AWS_ACCESS_KEY_ID null
ENV AWS_SECRET_ACCESS_KEY null
ENV AWS_DEFAULT_REGION null
ENV DYNAMODB_TABLE null
ENV S3_BUCKET null

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    apt-get update && \
    apt-get install -y cron jq && \
    pip install awscli && \
    rm -rf /var/lib/apt/lists/*

COPY crontab /etc/cron.d/dynamodb-backup
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY dynamodump.py /dynamodump.py
COPY run.sh /run.sh
RUN chmod 0644 /etc/cron.d/dynamodb-backup && touch /var/log/cron.log && chmod +x /dynamodump.py /run.sh

USER root:root
CMD env > /.env && cron && tail -f /var/log/cron.log

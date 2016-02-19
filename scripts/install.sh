#!/usr/bin/env bash

echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
echo "postfix postfix/mailname string mail.test.abich.com" >> preseed.txt
debconf-set-selections preseed.txt
apt-get update &&\
 DEBIAN_FRONTEND=noninteractive apt-get install -y postfix procmail ca-certificates vim curl rsyslog wget &&\
 rm -rf /var/lib/apt/lists/*

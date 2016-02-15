#!/usr/bin/env bash

service rsyslog start
service postfix start
sleep 2
tail -F /var/log/mail.log
#!/bin/bash

consul agent -config-dir /etc/consul -join consul &

postconf -e content_filter="smtp-amavis:[${AMAVIS_PORT_10024_TCP_ADDR}]:${AMAVIS_PORT_10024_TCP_PORT}"
postconf -e smtpd_recipient_restrictions="permit_sasl_authenticated,\
    reject_unauth_destination,\
    reject_invalid_hostname,\
    reject_unauth_pipelining,\
    reject_non_fqdn_hostname,\
    reject_non_fqdn_sender,\
    reject_non_fqdn_recipient,\
    reject_unknown_sender_domain,\
    reject_unknown_recipient_domain,\
    check_sender_access hash:/etc/postfix/access_sender,\
    reject_rbl_client blackholes.easynet.nl,\
    reject_rbl_client cbl.abuseat.org,\
    reject_rbl_client bl.spamcop.net,\
    reject_rbl_client zen.spamhaus.org,\
    reject_rbl_client dul.dnsbl.sorbs.net,\
    permit_mynetworks,\
    check_policy_service inet:${POSTGREY_PORT_60000_TCP_ADDR}:${POSTGREY_PORT_60000_TCP_PORT}"

/usr/local/bin/confd -backend consul -node localhost:8500 &

/usr/sbin/service cron start

/usr/sbin/logrotate -f /etc/logrotate.conf

exec $@

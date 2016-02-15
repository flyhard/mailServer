#!/usr/bin/env bash


postconf -e myhostname=mail.test.abich.com
postconf -e mydomain=test.abich.com
postconf -e mydestination="\$mydomain, \$myhostname, localhost.localdomain, localhost"
postconf -e mail_spool_directory="/var/spool/mail/"
postconf -e mailbox_command=""
postconf -e smtpd_client_restrictions="reject_rbl_client dnsbl.sorbs.net"
postconf -e smtpd_helo_restrictions="reject_invalid_helo_hostname, reject_non_fqdn_helo_hostname, reject_unknown_helo_hostname"
postconf -e smtpd_sender_restrictions=""
postconf -e smtpd_helo_required="yes"
postconf -e strict_rfc821_envelopes="yes"
postconf -e disable_vrfy_command="yes"
postconf -e unknown_address_reject_code="554"
postconf -e unknown_hostname_reject_code="554"
postconf -e unknown_client_reject_code="554"

postconf -e smtpd_data_restrictions="reject_unauth_pipelining, permit"
## Limit denial of Service
postconf -e default_process_limit="100"
postconf -e smtpd_client_connection_count_limit="10"
postconf -e smtpd_client_connection_rate_limit="30"
postconf -e header_size_limit="51200"
postconf -e smtp_recipient_limit="100"

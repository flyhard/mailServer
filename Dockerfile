FROM debian:jessie
MAINTAINER Per Abich <per.abich@gmail.com>

ADD scripts/ /scripts
RUN /scripts/install.sh
RUN /scripts/postgres-setup.sh

# Add a local user to receive mail at someone@example.com, with a delivery directory
# (for the Mailbox format).
#RUN useradd -s /bin/bash someone
#RUN mkdir /var/spool/mail/someone
#RUN chown someone:mail /var/spool/mail/someone

ADD /config/etc-aliases.txt /etc/aliases
RUN chown root:root /etc/aliases
RUN newaliases

ADD /config/access_sender /etc/postfix/access_sender
RUN postmap /etc/postfix/access_sender
# Use syslog-ng to get Postfix logs (rsyslog uses upstart which does not seem
# to run within Docker).
#RUN apt-get install -q -y syslog-ng

EXPOSE 25
RUN chmod +x /scripts/entrypoint.sh /scripts/run.sh

ADD etc /scripts

RUN /scripts/getConfdLatest.sh

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["/scripts/run.sh"]

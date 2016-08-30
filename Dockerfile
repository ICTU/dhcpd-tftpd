FROM alpine:3.4

RUN apk add --no-cache bash dhcp tftp-hpa net-tools supervisor rsyslog

ADD dhcpd/dhcpd.sh dhcpd/dhcpd.conf.template /usr/share/dhcpd/
ADD supervisor/supervisord.conf /etc/supervisord.conf
ADD rsyslogd/rsyslog.conf /etc/rsyslog.conf
ADD supervisor/conf.d /usr/share/supervisor/conf.d/

VOLUME /tftpboot /data

ENV SUBNET= NETMASK= RANGE_PXE= RANGE_STATIC= RANGE_OTHER= GATEWAY= SERVER_IP= NAMESERVERS= \
    DEFAULT_LEASE_TIME=600 \
    MAX_LEASE_TIME=1800

EXPOSE 67 67/udp 547 547/udp 647 647/udp 847 847/udp

ENTRYPOINT ["supervisord"]

CMD ["-c", "/etc/supervisord.conf", "-n"]

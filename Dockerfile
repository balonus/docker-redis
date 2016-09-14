FROM redis:3.2.3

MAINTAINER Michal Balinski <michal.balinski@gmail.com>

COPY ./entrypoint.sh /entrypoint.sh
RUN chown redis:redis /entrypoint.sh && \
    chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

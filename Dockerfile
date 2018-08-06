FROM derekamz/debian:latest
MAINTAINER Derek Chen <derekamz@gmail.com>

ENV COTURN_VER=4.5.0.7

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    coturn \
    && mkdir -p /opt/coturn/etc/ \
    && cd / && rm -rf /tmp/* \
    && apt-get remove --purge --auto-remove -y  build-essential \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh

VOLUME /opt/coturn/ 

EXPOSE 3478 3478/udp 5349 5349/udp 49152-65535/udp

CMD ["/bin/bash", "-c", "/entrypoint.sh"]
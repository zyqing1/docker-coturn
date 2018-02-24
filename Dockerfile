FROM derekamz/debian:latest
MAINTAINER Derek Chen <derekamz@gmail.com>

ENV COTURN_VER=4.5.0.7

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libtool \
    libssl-dev \
    libevent-dev \
    libyajl-dev	\
    libcurl4-openssl-dev \
    libsqlite3-dev \
    && cd /tmp \
    && curl -skL https://github.com/coturn/coturn/archive/${COTURN_VER}.tar.gz -o coturn.tar.gz \
    && tar xzf coturn.tar.gz \
    && cd coturn-${COTURN_VER} \
    && ./configure && make && make install \
    && mkdir -p /opt/coturn/etc/ \
    && cp /usr/local/etc/turnserver.conf.default /opt/coturn/etc/turnserver.conf \
    && cd / && rm -rf /tmp/* \
    && apt-get remove --purge --auto-remove -y  build-essential

ADD entrypoint.sh /entrypoint.sh

VOLUME /opt/coturn/ 

EXPOSE 3478 3478/udp 5349 5349/udp 49152-65535/udp

CMD ["/bin/bash", "-c", "/entrypoint.sh"]
FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r redis && useradd -r -g redis redis

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		apt-utils \
	&& rm -rf /var/lib/apt/lists/*

COPY haproxy-1.6.4.tar.gz haproxy.tar.gz

# for redis-sentinel see: http://redis.io/topics/sentinel
RUN buildDeps='gcc libc6-dev make' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 \
	&& rm haproxy.tar.gz \
	&& make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 -C /usr/src/haproxy \
	&& make -C /usr/src/haproxy haproxy \
	&& rm -r /usr/src/haproxy \
	&& apt-get purge -y --auto-remove $buildDeps

COPY docker-entrypoint.sh /entrypoint.sh
COPY haproxy.cfg /haproxy.cfg

RUN mkdir /data \
	&& chmod +x /entrypoint.sh \
	&& chmod +x /usr/local/bin/gosu

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "haproxy", "-f", "/haproxy.cfg" ]


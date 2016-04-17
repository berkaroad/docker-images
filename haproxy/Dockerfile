#FROM debian:jessie
FROM registry.aliyuncs.com/freshncp/debian
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

COPY haproxy-1.6.4.tar.gz haproxy.tar.gz

RUN buildDeps='gcc libc6-dev libpcre3-dev libssl-dev make' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/haproxy \
	&& tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 \
	&& rm haproxy.tar.gz \
	&& make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 -C /usr/src/haproxy \
	&& make -C /usr/src/haproxy install \
	&& rm -r /usr/src/haproxy \
	&& apt-get purge -y --auto-remove $buildDeps

COPY haproxy-web.cfg /haproxy.cfg

RUN mkdir /data \
	&& echo '[program:haproxy]' > /etc/supervisor/conf.d/haproxy.conf \
	&& echo 'command=haproxy -f /haproxy.cfg' >> /etc/supervisor/conf.d/haproxy.conf

VOLUME /data

EXPOSE 80
EXPOSE 443
EXPOSE 3306
EXPOSE 13306
EXPOSE 8888
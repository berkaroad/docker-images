FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		apt-utils \
	&& rm -rf /var/lib/apt/lists/*

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

COPY docker-entrypoint.sh /entrypoint.sh
COPY haproxy.cfg /haproxy.cfg

RUN mkdir /data \
	&& chmod +x /entrypoint.sh

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "haproxy", "-f", "/haproxy.cfg" ]

EXPOSE 80
EXPOSE 443
EXPOSE 3306
EXPOSE 3307
EXPOSE 8888
FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		apt-utils \
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd -r redis && useradd -r -g redis redis

COPY redis-3.0.7.tar.gz redis.tar.gz

RUN buildDeps='gcc libc6-dev libjemalloc-dev make' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install \
	&& rm -r /usr/src/redis \
	&& apt-get purge -y --auto-remove $buildDeps

COPY docker-entrypoint.sh /entrypoint.sh
COPY gosu /usr/local/bin/gosu
COPY redis.conf /redis.conf

RUN mkdir /data \
	&& chown redis:redis /data \
	&& chmod +x /entrypoint.sh \
	&& chmod +x /usr/local/bin/gosu

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "redis-server", "/redis.conf" ]

EXPOSE 6379
EXPOSE 16379
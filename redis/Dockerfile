FROM registry.aliyuncs.com/freshncp/debian-ssh
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

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

COPY docker-entrypoint.sh /entrypoint-redis.sh
COPY redis.conf /redis.conf

RUN mkdir /data \
	&& chmod +x /entrypoint-redis.sh \
	&& echo '[program:redis]' > /etc/supervisor/conf.d/redis.conf \
	&& echo 'command=/entrypoint-redis.sh' >> /etc/supervisor/conf.d/redis.conf \
	&& echo 'autostart=true' >> /etc/supervisor/conf.d/redis.conf \
	&& echo 'autorestart=true' >> /etc/supervisor/conf.d/redis.conf

VOLUME /data
WORKDIR /data

EXPOSE 6379 EXPOSE 16379
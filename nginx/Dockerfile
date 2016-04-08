FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		apt-utils \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
		nginx \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint.sh
COPY nginx.conf /nginx.conf

RUN mkdir -p /data/sites-enabled \
	&& mkdir -p /data/conf.d \
	&& mkdir -p /data/log \
	&& mkdir -p /data/wwwroot \
	&& chown -R www-data:www-data /data \
	&& chmod +x /entrypoint.sh

VOLUME /data/sites-enabled
VOLUME /data/conf.d
VOLUME /data/log
VOLUME /data/wwwroot
WORKDIR /data


ENTRYPOINT ["/entrypoint.sh"]
CMD [ "nginx", "-c", "/nginx.conf" ]

EXPOSE 80
EXPOSE 443
FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
		nginx \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data/sites-enabled \
	&& mkdir -p /data/conf.d \
	&& mkdir -p /data/wwwroot \
	&& chown -R www-data:www-data /data
VOLUME /data/sites-enabled
VOLUME /data/conf.d
VOLUME /data/wwwroot
WORKDIR /data

COPY docker-entrypoint.sh /entrypoint.sh
COPY nginx.conf /nginx.conf
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
EXPOSE 443

CMD [ "nginx", "-c", "/nginx.conf" ]

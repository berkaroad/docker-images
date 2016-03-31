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
	&& mkdir -p /data/wwwroot \
	&& chown -R www-data:www-data /data
	&& chown www-data:www-data /entrypoint.sh \
	&& chmod 744 /entrypoint.conf \
	&& chown www-data:www-data /nginx.conf \
	&& chmod 644 /nginx.conf

VOLUME /data/sites-enabled
VOLUME /data/conf.d
VOLUME /data/wwwroot
WORKDIR /data


ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
EXPOSE 443

CMD [ "nginx", "-c", "/nginx.conf" ]

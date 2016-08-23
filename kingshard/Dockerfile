FROM registry.aliyuncs.com/freshncp/java
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint-kingshard.sh
COPY kingshard.tar.gz /tmp/kingshard.tar.gz

RUN tar zxvf /tmp/kingshard.tar.gz -C /opt \
	&& rm /tmp/kingshard.tar.gz \
	&& cp -R /opt/kingshard/conf /opt/kingshard/conf.defaults


VOLUME /opt/kingshard/conf
VOLUME /opt/kingshard/log
WORKDIR /opt/kingshard

RUN chmod +x /entrypoint-kingshard.sh \
	&& echo '[program:kingshard]' > /etc/supervisor/conf.d/kingshard.conf \
	&& echo 'command=/entrypoint-kingshard.sh' >> /etc/supervisor/conf.d/kingshard.conf


# Proxy port
EXPOSE 9696
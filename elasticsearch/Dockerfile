FROM registry.aliyuncs.com/freshncp/debian-ssh
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-7-jre-headless \
  && rm -rf /var/lib/apt/lists/*
RUN sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

COPY elasticsearch-2.3.3.deb /tmp/elasticsearch.deb
RUN dpkg -i /tmp/elasticsearch.deb \
	&& rm /tmp/elasticsearch.deb

COPY docker-entrypoint.sh /entrypoint-elasticsearch.sh
COPY config /usr/share/elasticsearch/config

RUN chmod +x /entrypoint-elasticsearch.sh \
	&& mkdir -p /usr/share/elasticsearch/data \
	&& mkdir -p /usr/share/elasticsearch/config/scripts \
	&& mkdir -p /usr/share/elasticsearch/logs \
	&& echo '[program:elasticsearch]' > /etc/supervisor/conf.d/elasticsearch.conf \
	&& echo 'command=/entrypoint-elasticsearch.sh' >> /etc/supervisor/conf.d/elasticsearch.conf \
	&& echo 'autostart=true' >> /etc/supervisor/conf.d/elasticsearch.conf \
	&& echo 'autorestart=true' >> /etc/supervisor/conf.d/elasticsearch.conf

VOLUME /usr/share/elasticsearch/data
VOLUME /usr/share/elasticsearch/config/scripts
WORKDIR /usr/share/elasticsearch

EXPOSE 9200 9300
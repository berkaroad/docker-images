FROM registry.aliyuncs.com/freshncp/debian-ssh
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4

ENV ELASTICSEARCH_MAJOR 2.3
ENV ELASTICSEARCH_VERSION 2.3.3
ENV ELASTICSEARCH_REPO_BASE http://packages.elasticsearch.org/elasticsearch/2.x/debian

RUN echo "deb $ELASTICSEARCH_REPO_BASE stable main" > /etc/apt/sources.list.d/elasticsearch.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-7-jre-headless \
    elasticsearch=$ELASTICSEARCH_VERSION \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

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
EXPOSE 9200 9300
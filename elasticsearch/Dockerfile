FROM registry.aliyuncs.com/freshncp/java
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

COPY elasticsearch-2.3.3.deb /tmp/elasticsearch.deb
RUN dpkg -i /tmp/elasticsearch.deb \
	&& rm /tmp/elasticsearch.deb

RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head

ENV ELASTICSEARCH_CLUSTERNAME "elasticsearch"
ENV ELASTICSEARCH_NODENAME "node1"
ENV ELASTICSEARCH_RACK "rack1"
ENV ELASTICSEARCH_SHARDS 5
ENV ELASTICSEARCH_REPLICAS 1
ENV ELASTICSEARCH_PUBLISH_HOST "127.0.0.1"
ENV ELASTICSEARCH_UNICAST_HOSTS "127.0.0.1:9300"
ENV ELASTICSEARCH_HTTP_PORT 9200
ENV ELASTICSEARCH_TCP_PORT 9300

COPY docker-entrypoint.sh /entrypoint-elasticsearch.sh
COPY config /usr/share/elasticsearch/config
RUN chmod +x /entrypoint-elasticsearch.sh \
	&& mkdir -p /usr/share/elasticsearch/data \
	&& mkdir -p /usr/share/elasticsearch/config/scripts \
	&& mkdir -p /usr/share/elasticsearch/logs \
	&& mkdir -p /usr/share/elasticsearch/backups \
	&& echo '[program:elasticsearch]' > /etc/supervisor/conf.d/elasticsearch.conf \
	&& echo 'command=/entrypoint-elasticsearch.sh' >> /etc/supervisor/conf.d/elasticsearch.conf \
	&& echo 'autostart=true' >> /etc/supervisor/conf.d/elasticsearch.conf \
	&& echo 'autorestart=true' >> /etc/supervisor/conf.d/elasticsearch.conf

VOLUME /usr/share/elasticsearch/data
VOLUME /usr/share/elasticsearch/config/scripts
VOLUME /usr/share/elasticsearch/backups
WORKDIR /usr/share/elasticsearch

EXPOSE 9200 9300
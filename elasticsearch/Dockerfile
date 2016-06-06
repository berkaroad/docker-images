FROM registry.aliyuncs.com/freshncp/java
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

COPY elasticsearch-2.3.3.deb /tmp/elasticsearch.deb
RUN dpkg -i /tmp/elasticsearch.deb \
	&& rm /tmp/elasticsearch.deb

RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head

ENV ELASTICSEARCH_CLUSTERNAME "elasticsearch"
ENV ELASTICSEARCH_NODENAME "node1"
ENV ELASTICSEARCH_RACK "rack1"

COPY docker-entrypoint.sh /entrypoint-elasticsearch.sh
COPY config /usr/share/elasticsearch/config
#COPY generate_elasticsearchconfig.sh /usr/share/elasticsearch/bin/generate_elasticsearchconfig.sh
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
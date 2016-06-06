FROM registry.aliyuncs.com/freshncp/java
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libzmq3 \
    logrotate \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/lib \
    && ln -s /usr/lib/*/libzmq.so.3 /usr/local/lib/libzmq.so

COPY logstash_2.3.2-1_all.deb /tmp/logstash_all.deb
RUN dpkg -i /tmp/logstash_all.deb \
	&& rm /tmp/logstash_all.deb

COPY docker-entrypoint.sh /entrypoint-logstash.sh
COPY logstash.cfg /logstash.cfg
COPY generate_config.sh /opt/logstash/bin/generate_config.sh

RUN chmod +x /entrypoint-logstash.sh \
	&& chmod +x /opt/logstash/bin/generate_config.sh \
	&& mkdir /data \
	&& echo '[program:logstash]' > /etc/supervisor/conf.d/logstash.conf \
	&& echo 'command=/entrypoint-logstash.sh' >> /etc/supervisor/conf.d/logstash.conf \
	&& echo 'autostart=true' >> /etc/supervisor/conf.d/logstash.conf \
	&& echo 'autorestart=true' >> /etc/supervisor/conf.d/logstash.conf

VOLUME /data
WORKDIR /opt/logstash

# $LOGSTASH_ROLE = "indexer" | "shipper"
ENV LOGSTASH_ROLE "indexer"
ENV LOGSTASH_ID "demo"

EXPOSE 8080
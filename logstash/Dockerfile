FROM registry.aliyuncs.com/freshncp/debian-ssh
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4

ENV LOGSTASH_MAJOR 2.3
ENV LOGSTASH_VERSION 1:2.3.2-1

RUN echo "deb http://packages.elastic.co/logstash/${LOGSTASH_MAJOR}/debian stable main" > /etc/apt/sources.list.d/logstash.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    libzmq3 \
    openjdk-7-jre-headless \
    logstash=$LOGSTASH_VERSION \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security

RUN mkdir -p /usr/local/lib \
    && ln -s /usr/lib/*/libzmq.so.3 /usr/local/lib/libzmq.so

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
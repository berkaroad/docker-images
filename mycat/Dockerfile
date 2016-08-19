FROM registry.aliyuncs.com/freshncp/java
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint-mycat.sh
COPY Mycat-server-1.5.1-RELEASE-linux.tar.gz /tmp/mycat-server.tar.gz

RUN tar zxvf /tmp/mycat-server.tar.gz -C /opt \
	&& rm /tmp/mycat-server.tar.gz \
	&& cp -R /opt/mycat/conf /opt/mycat/conf.defaults


VOLUME /opt/mycat/conf
VOLUME /opt/mycat/log
WORKDIR /opt/mycat

RUN chmod +x /entrypoint-mycat.sh \
	&& echo '[program:mycat]' > /etc/supervisor/conf.d/mycat.conf \
	&& echo 'command=/entrypoint-mycat.sh' >> /etc/supervisor/conf.d/mycat.conf


# Proxy port
EXPOSE 8066
# Admin port
EXPOSE 9066
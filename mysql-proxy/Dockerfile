FROM registry.aliyuncs.com/freshncp/debian-ssh
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		mysql-proxy \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /etc/mysql \
	&& mkdir -p /var/lib/mysql-proxy \
	&& mkdir -p /var/log/mysql-proxy 

ENV MYSQL_PROXY_CNF "/etc/mysql/mysql-proxy.cnf"

COPY docker-entrypoint.sh /entrypoint-mysql-proxy.sh
COPY mysql-proxy.cnf /etc/mysql/mysql-proxy.cnf

VOLUME /var/lib/mysql-proxy
VOLUME /var/log/mysql-proxy 
WORKDIR /var/lib/mysql-proxy

RUN chmod +x /entrypoint-mysql-proxy.sh \
	&& echo '[program:mysql-proxy]' > /etc/supervisor/conf.d/mysql-proxy.conf \
	&& echo 'command=/entrypoint-mysql-proxy.sh' >> /etc/supervisor/conf.d/mysql-proxy.conf

# Proxy port
EXPOSE 4040
# Admin port
EXPOSE 4041
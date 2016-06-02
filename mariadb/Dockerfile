#FROM debian:jessie
FROM registry.aliyuncs.com/freshncp/debian
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN groupadd -r mysql && useradd -r -g mysql mysql

ENV MARIADB_MAJOR 10.1
ENV MARIADB_VERSION 10.1.13+maria-1~jessie

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 199369E5404BD5FC7D2FE43BCBCB082A1BB943DB \
	&& echo "deb http://ftp.osuosl.org/pub/mariadb/repo/$MARIADB_MAJOR/debian jessie main" > /etc/apt/sources.list.d/mariadb.list \
	&& echo 'Package: *' > /etc/apt/preferences.d/mariadb \
	&& echo 'Pin: release o=MariaDB' >> /etc/apt/preferences.d/mariadb \
	&& echo 'Pin-Priority: 999' >> /etc/apt/preferences.d/mariadb

RUN echo "mariadb-server-$MARIADB_MAJOR mysql-server/root_password password 'unused'" | debconf-set-selections \
	&& echo "mariadb-server-$MARIADB_MAJOR mysql-server/root_password_again password 'unused'" | debconf-set-selections \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		mariadb-server=$MARIADB_VERSION \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/lib/mysql \
	&& mkdir -p /var/lib/mysql \
	&& mkdir -p /var/log/mysql \
	&& mkdir -p /etc/mysql/conf.d

RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
	&& echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
	&& mv /tmp/my.cnf /etc/mysql/my.cnf

COPY docker-entrypoint.sh /entrypoint-mariadb.sh
COPY my.cnf /etc/mysql/my.cnf

VOLUME /var/lib/mysql
VOLUME /etc/mysql/conf.d
VOLUME /var/log/mysql
WORKDIR /var/lib/mysql

RUN chmod +x /entrypoint-mariadb.sh \
	&& echo '[program:mysqld]' > /etc/supervisor/conf.d/mysqld.conf \
	&& echo 'command=/entrypoint-mariadb.sh' >> /etc/supervisor/conf.d/mysqld.conf

EXPOSE 3306
# Check DB Status
EXPOSE 9200
# Check Replication Status
EXPOSE 9201
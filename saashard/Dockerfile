FROM registry.aliyuncs.com/freshncp/debian-ssh
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint-saashard.sh
COPY saashard_0.1-linux_amd64.tar.gz /tmp/saashard.tar.gz

RUN tar zxvf /tmp/saashard.tar.gz -C /opt \
	&& rm /tmp/saashard.tar.gz \
	&& cp -R /opt/saashard/conf /opt/saashard/conf.defaults


VOLUME /opt/saashard/conf
VOLUME /opt/saashard/log
WORKDIR /opt/saashard

RUN chmod +x /entrypoint-saashard.sh \
	&& echo '[program:saashard]' > /etc/supervisor/conf.d/saashard.conf \
	&& echo 'command=/entrypoint-saashard.sh' >> /etc/supervisor/conf.d/saashard.conf \
    && echo 'autostart=true' >> /etc/supervisor/conf.d/saashard.conf \
    && echo 'autorestart=true' >> /etc/supervisor/conf.d/saashard.conf \
    && echo 'redirect_stderr=true' >> /etc/supervisor/conf.d/saashard.conf


# Proxy port
EXPOSE 6051
# Admin port
EXPOSE 16051
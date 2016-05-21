#FROM debian:jessie
FROM registry.aliyuncs.com/freshncp/debian
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		openssh-server \
	&& rm -rf /var/lib/apt/lists/*

ENV SSH_ROOT ssh-rsa

COPY docker-entrypoint.sh /entrypoint-openssh.sh

RUN chmod +x /entrypoint-openssh.sh \
	&& sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
	&& sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config \
	&& echo 'GatewayPorts yes' >> /etc/ssh/sshd_config \
	&& mkdir -p /root/.ssh \
	&& mkdir -p /var/run/sshd \
	&& echo '[program:sshd]' > /etc/supervisor/conf.d/sshd.conf \
	&& echo 'command=/entrypoint-openssh.sh /usr/sbin/sshd -D' >> /etc/supervisor/conf.d/sshd.conf \
	&& echo 'autostart=true' >> /etc/supervisor/conf.d/sshd.conf \
	&& echo 'autorestart=true' >> /etc/supervisor/conf.d/sshd.conf \
	&& echo 'redirect_stderr=true' >> /etc/supervisor/conf.d/sshd.conf

EXPOSE 22

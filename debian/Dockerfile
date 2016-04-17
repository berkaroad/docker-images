FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		apt-utils \
		openssh-server \
		vim \
		supervisor \
	&& rm -rf /var/lib/apt/lists/*

ENV SSH_AUTHORIZED_KEYS ssh-rsa

COPY docker-entrypoint.sh /entrypoint.sh
COPY gosu /usr/local/bin/gosu
COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN chmod +x /entrypoint.sh \
	&& chmod +x /usr/local/bin/gosu \
	&& sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
	&& sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config \
	&& mkdir -p /root/.ssh \
	&& mkdir -p /var/run/sshd \
	&& echo 'set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936' > /root/.vimrc \
	&& echo 'set termencoding=utf-8' >> /root/.vimrc \
	&& echo 'set encoding=utf-8' >> /root/.vimrc

VOLUME /etc/supervisor/conf.d

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "supervisord" ]

EXPOSE 22
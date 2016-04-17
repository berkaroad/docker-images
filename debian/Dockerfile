FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		apt-utils \
		ssh \
		nano \
		supervisor \
	&& rm -rf /var/lib/apt/lists/*

COPY gosu /usr/local/bin/gosu
COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN chmod +x /usr/local/bin/gosu \
	&& sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

VOLUME /etc/supervisor/conf.d

CMD [ "supervisord" ]

EXPOSE 22
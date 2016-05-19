FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
		apt-utils \
		vim \
		supervisor \
		net-tools \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint.sh
COPY gosu /usr/local/bin/gosu
COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /usr/share/fonts/truetype/microsoft
COPY arial.ttf /usr/share/fonts/truetype/microsoft/arial.ttf
COPY simsun.ttf /usr/share/fonts/truetype/microsoft/simsun.ttf
RUN cd /usr/share/fonts/truetype/microsoft \
	&& mkfontscale \
	&& mkfontdir \
	&& fc-cache
	&& cd /root

RUN chmod +x /entrypoint.sh \
	&& chmod +x /usr/local/bin/gosu \
	&& echo 'set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936' > /root/.vimrc \
	&& echo 'set termencoding=utf-8' >> /root/.vimrc \
	&& echo 'set encoding=utf-8' >> /root/.vimrc \
	&& mkdir -p /supervisor

VOLUME /supervisor

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "supervisord" ]

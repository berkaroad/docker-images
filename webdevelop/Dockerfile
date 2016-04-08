FROM debian:jessie
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		apt-utils \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
		nano \
		vim \
		golang \
		git \
	&& rm -rf /var/lib/apt/lists/*

RUN echo 'set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936' > /root/.vimrc
	&& echo 'set termencoding=utf-8' >> /root/.vimrc
	&& echo 'set encoding=utf-8' >> /root/.vimrc

COPY docker-entrypoint.sh /entrypoint.sh

RUN mkdir /data \
	mkdir -p /data/go \
	&& chmod +x /entrypoint.sh

VOLUME /data
WORKDIR /data

ENV GOPATH /data/go

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "/bin/bash" ]
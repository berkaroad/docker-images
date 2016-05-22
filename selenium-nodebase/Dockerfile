FROM registry.aliyuncs.com/freshncp/selenium-base
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV TZ "US/Pacific"
ENV SCREEN_WIDTH 1280
ENV SCREEN_HEIGHT 800
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0
  
RUN apt-get update && apt-get install -y --no-install-recommends \
		xorg \
		xauth \
    	xvfb \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

COPY docker-entrypoint.sh /entrypoint-selenium-nodebase.sh
COPY functions.sh /opt/selenium/functions.sh

RUN chmod +x /entrypoint-selenium-nodebase.sh \
	&& chmod +x /opt/selenium/functions.sh \
	&& echo '[program:selenium-nodebase]' > /etc/supervisor/conf.d/selenium-nodebase.conf \
	&& echo 'command=/entrypoint-selenium-nodebase.sh' >> /etc/supervisor/conf.d/selenium-nodebase.conf \
	&& echo 'autostart=true' >> /etc/supervisor/conf.d/selenium-nodebase.conf \
	&& echo 'autorestart=true' >> /etc/supervisor/conf.d/selenium-nodebase.conf
FROM registry.aliyuncs.com/freshncp/selenium-base
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

EXPOSE 4444

ENV GRID_NEW_SESSION_WAIT_TIMEOUT -1
ENV GRID_JETTY_MAX_THREADS -1
ENV GRID_NODE_POLLING  5000
ENV GRID_CLEAN_UP_CYCLE 5000
ENV GRID_TIMEOUT 30000
ENV GRID_BROWSER_TIMEOUT 0
ENV GRID_MAX_SESSION 5
ENV GRID_UNREGISTER_IF_STILL_DOWN_AFTER 30000

COPY docker-entrypoint.sh /entrypoint-selenium-hub.sh
COPY generate_config /opt/selenium/generate_config

RUN chmod +x /entrypoint-selenium-hub.sh \
	&& echo '[program:selenium-hub]' > /etc/supervisor/conf.d/selenium-hub.conf \
	&& echo 'command=/entrypoint-selenium-hub.sh /entrypoint-selenium-hub.sh' >> /etc/supervisor/conf.d/selenium-hub.conf \
	&& echo 'autostart=true' >> /etc/supervisor/conf.d/selenium-hub.conf \
	&& echo 'autorestart=true' >> /etc/supervisor/conf.d/selenium-hub.conf

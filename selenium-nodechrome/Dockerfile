FROM registry.aliyuncs.com/freshncp/selenium-nodebase
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

#===============
# Google Chrome
#===============
COPY google-chrome-stable_50.0.2661.102-1_amd64.deb /tmp/google-chrome-stable_amd64.deb
RUN dpkg -i /tmp/google-chrome-stable_amd64.deb \
	&& rm /tmp/google-chrome-stable_amd64.deb

#==================
# Chrome webdriver
#==================
ENV CHROME_DRIVER_VERSION 2.21
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
	&& rm -rf /opt/selenium/chromedriver \
	&& unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
	&& rm /tmp/chromedriver_linux64.zip \
	&& mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
	&& chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
	&& ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

#========================
# Selenium Configuration
#========================
COPY config.json /opt/selenium/config.json

#=================================
# Chrome Launch Script Modication
#=================================
COPY docker-entrypoint.sh /entrypoint-selenium-nodechrome.sh
RUN chmod +x /entrypoint-selenium-nodechrome.sh

# Following line fixes
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
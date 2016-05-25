FROM registry.aliyuncs.com/freshncp/java
MAINTAINER berkaroad "jiarong.bai198605@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    unzip \
  && rm -rf /var/lib/apt/lists/*

RUN  mkdir -p /opt/selenium
# wget --no-verbose https://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.0.jar -O /opt/selenium/selenium-server-standalone.jar
COPY selenium-server-standalone-2.53.0.jar /opt/selenium/selenium-server-standalone.jar

WORKDIR /opt/selenium
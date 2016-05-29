#!/bin/sh
# Build all docker images.

if [ -f $0 ] && [ "$0" = "./build.sh" ]; then
    DF_ROOT=`pwd`

    cd $DF_ROOT/debian
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/debian-ssh
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/haproxy
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/redis
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/java
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/selenium-base
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/selenium-nodebase
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/selenium-hub
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/selenium-nodechrome
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/elasticsearch
    chmod +x ./build.sh && ./build.sh

    cd $DF_ROOT/logstash
    chmod +x ./build.sh && ./build.sh


    cd $DF_ROOT
else
    echo "Please run like this: \"./build.sh\"."
fi

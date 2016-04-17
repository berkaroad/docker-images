#创建容器运行脚本run.sh

    #/bin/bash
    #docker pull registry.aliyuncs.com/freshncp/debian
    docker stop debian 2> /dev/null
    docker rm debian 2> /dev/null

    docker run --name debian -d \
        -v `pwd`/data/supervisor:/supervisor \
        registry.aliyuncs.com/freshncp/debian

    cat `pwd`/id_rsa

#Supervisor

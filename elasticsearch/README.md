##创建容器运行脚本run.sh

    #/bin/bash
    #docker pull registry.aliyuncs.com/freshncp/elasticsearch
    docker stop elasticsearch 2> /dev/null
    docker rm elasticsearch 2> /dev/null

    docker run --name elasticsearch -d \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/elasticsearch:/usr/share/elasticsearch/data \
        -p 9200:9200 \
        -p 9300:9300 \
        registry.aliyuncs.com/freshncp/elasticsearch

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如elasticsearch.conf

    [program:elasticsearch]
    command=/usr/share/elasticsearch/bin/elasticsearch
    autostart=true
    autorestart=true
    redirect_stderr=true
##创建容器运行脚本run.sh

    #/bin/bash
    #docker pull registry.aliyuncs.com/freshncp/logstash
    docker stop logstash 2> /dev/null
    docker rm logstash 2> /dev/null

    docker run --name logstash -d \
        -v `pwd`/supervisor:/supervisor \
        registry.aliyuncs.com/freshncp/logstash

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如logstash.conf

    [program:logstash]
    command=/entrypoint-logstash.sh
    autostart=true
    autorestart=true
    redirect_stderr=true
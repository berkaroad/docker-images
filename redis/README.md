##创建容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/redis
    docker stop redis 2> /dev/null
    docker rm redis 2> /dev/null

    docker run --name redis -d \
        -e SSH_ROOT="$authorized_keys" \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/redis:/data \
        -p 6379:6379 \
        -p 16379:16379 \
        registry.aliyuncs.com/freshncp/redis

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如redis.conf

    [program:redis]
    command=/usr/local/bin/redis-server /data/redis.conf
    autostart=true
    autorestart=true
    redirect_stderr=true
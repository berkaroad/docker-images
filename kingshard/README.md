##创建kingshard容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/kingshard
    docker stop kingshard 2> /dev/null
    docker rm kingshard 2> /dev/null

    docker run --name kingshard -d \
        -e SSH_ROOT="$authorized_keys" \
        -p 9696:9696 \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/conf:/opt/kingshard/conf \
        -v `pwd`/log:/opt/kingshard/log \
        registry.aliyuncs.com/freshncp/kingshard

    cat `pwd`/id_rsa


##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如kingshard.conf

    [program:kingshard]
    command=/entrypoint-kingshard.sh
    autostart=true
    autorestart=true
    redirect_stderr=true
## 创建saashard容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/saashard
    docker stop saashard 2> /dev/null
    docker rm saashard 2> /dev/null

    docker run --name saashard -d \
        -e SSH_ROOT="$authorized_keys" \
        -p 6051:6051 \
        -p 16051:16051 \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/conf:/opt/saashard/conf \
        -v `pwd`/log:/opt/saashard/log \
        registry.aliyuncs.com/freshncp/saashard

    cat `pwd`/id_rsa


## 进行ssh连接

    ssh root@<docker_ip> -i id_rsa

## Supervisor

在容器目录/supervisor下添加配置文件，如saashard.conf

    [program:saashard]
    command=/entrypoint-saashard.sh
    autostart=true
    autorestart=true
    redirect_stderr=true
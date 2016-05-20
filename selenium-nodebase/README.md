##创建容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/selenium-nodebase
    docker stop selenium-nodebase 2> /dev/null
    docker rm selenium-nodebase 2> /dev/null

    docker run --name selenium-nodebase -d \
        -e SSH_ROOT="$authorized_keys" \
        -v `pwd`/supervisor:/supervisor \
        registry.aliyuncs.com/freshncp/selenium-nodebase

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如selenium-nodebase.conf

    [program:selenium-nodebase]
    command=/entrypoint-selenium-nodebase.sh
    autostart=true
    autorestart=true
    redirect_stderr=true
##创建容器运行脚本run.sh

    #/bin/bash
    #docker pull registry.aliyuncs.com/freshncp/debian
    docker stop debian 2> /dev/null
    docker rm debian 2> /dev/null

    docker run --name debian -d \
        -v `pwd`/data/supervisor:/supervisor \
        registry.aliyuncs.com/freshncp/debian

    cat `pwd`/id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如sshd.conf

    [program:sshd]
    command=/entrypoint-openssh.sh /usr/sbin/sshd -D
    autostart=true
    autorestart=true
    redirect_stderr=true
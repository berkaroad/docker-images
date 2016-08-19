##创建MyCAT容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/mycat
    docker stop mycat 2> /dev/null
    docker rm mycat 2> /dev/null

    docker run --name mycat -d \
        -e SSH_ROOT="$authorized_keys" \
        -p 8066:8066 \
        -p 9066:9066 \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/conf:/opt/mycat/conf \
        -v `pwd`/log:/opt/mycat/log \
        registry.aliyuncs.com/freshncp/mycat

    cat `pwd`/id_rsa


##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如mycat.conf

    [program:mycat]
    command=/entrypoint-mycat.sh
    autostart=true
    autorestart=true
    redirect_stderr=true
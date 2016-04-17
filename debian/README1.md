#OpenSSH
##创建容器运行脚本run.sh

    #/bin/bash
    rm -rf `pwd`/id_rsa* 2> /dev/null
    ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/debian
    docker stop debian 2> /dev/null
    docker rm debian 2> /dev/null

    docker run --name debian -d \
        -e SSH_AUTHORIZED_KEYS="$authorized_keys" \
        -p 9022:22 \
        -v `pwd`/data/supervisor:/supervisor \
        registry.aliyuncs.com/freshncp/debian

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

#Supervisor
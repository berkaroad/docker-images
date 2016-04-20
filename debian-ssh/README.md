##创建容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/debian-ssh
    docker stop debian-ssh 2> /dev/null
    docker rm debian-ssh 2> /dev/null

    docker run --name debian-ssh -d \
        -e SSH_ROOT="$authorized_keys" \
        -p 9022:22 \
        -v `pwd`/supervisor:/supervisor \
        registry.aliyuncs.com/freshncp/debian-ssh

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa
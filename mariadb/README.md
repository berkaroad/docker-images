##创建mariadb容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/mariadb
    docker stop mysql 2> /dev/null
    docker rm mysql 2> /dev/null

    docker run --name mysql -d \
        -e SSH_ROOT="$authorized_keys" \
        -p 3306:3306 \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/data:/var/lib/mysql \
        -v `pwd`/conf.d:/etc/mysql/conf.d \
        -v `pwd`/log:/var/log/mysql \
        -e 'MYSQL_ROOT_PASSWORD=123456' \
        registry.aliyuncs.com/freshncp/mariadb

    cat `pwd`/id_rsa


##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如mysqld.conf

    [program:mysqld]
    command=/entrypoint-mariadb.sh mysqld
    autostart=true
    autorestart=true
    redirect_stderr=true

##genericlog.cnf

    [mysqld]
    general_log=0
    general_log_file=/var/log/mysql/mysql.log

##slowlog.cnf

    [mysqld]
    slow_query_log=1
    long_query_time=1
    log_slow_rate_limit=1000
    log_slow_verbosity=query_plan
    log-queries-not-using-indexes
    slow_query_log_file=/var/log/mysql/mariadb-slow.log
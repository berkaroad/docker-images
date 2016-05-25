##创建容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/haproxy
    docker stop haproxy 2> /dev/null
    docker rm haproxy 2> /dev/null

    docker run --name haproxy -d \
        -e SSH_ROOT="$authorized_keys" \
        -p 9022:22 \
        -p 80:80 \
        -p 443:443 \
        -p 3306:3306 \
        -p 13306:13306 \
        -p 8888:8888 \
        -v `pwd`/haproxy:/data \
        -v `pwd`/supervisor:/supervisor \
        registry.aliyuncs.com/freshncp/haproxy

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如haproxy.conf

    [program:haproxy]
    command=/usr/local/sbin/haproxy -f /data/haproxy.cfg
    autostart=true
    autorestart=true
    redirect_stderr=true

##HAProxy

    global
        log 127.0.0.1 local0 info # sync: log 127.0.0.1 local[num] {err|warning|info|debug}
        pidfile /var/run/haproxy.pid
        uid 99
        gid 99
        quiet
        nbproc 1 # Equal with CPU core
        maxconn 1024

    defaults
        log 127.0.0.1 local3 err
        mode    tcp # synax: mode {http|tcp|heath}
        # synax: balance {roundrobin|leastconn|source|uri|uri_param<param_name>|hdr(<header_name>)}
        balance roundrobin
        retries 3 # max retry count
        option  httplog
        option  dontlognull # record null conn or not
        option redispatch # allow redispatch when con fail or close
        option abortonclose
        option httpclose
        maxconn 10240 
        timeout connect    5s
        timeout client     60s
        timeout server     3s
        timeout http-request 3s
        timeout http-keep-alive 10s
        timeout queue     3s
        timeout check 10s

    listen status
        bind *:8888
        mode http
        stats enable
        stats refresh 60s
        stats uri /
        stats realm Haproxy \ statistic
        stats auth haproxyadmin:haproxypass
        stats hide-version


    frontend web_80
        bind *:80
        mode http
        log global
        option httpclose
        option forwardfor
        default_backend web_80_backend
    backend web_80_backend
        mode http
        balance roundrobin
        option httpchk HEAD /
        server webapp1 127.0.0.1:8001 weight 1 check cookie node1 inter 2000 rise 2 fall 3
        server webapp2 127.0.0.1:8001 weight 1 check cookie node2 inter 2000 rise 2 fall 3

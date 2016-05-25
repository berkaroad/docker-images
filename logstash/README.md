##创建容器运行脚本run.sh

    #/bin/bash
    #rm -rf `pwd`/id_rsa* 2> /dev/null
    if [ ! -f `pwd`/id_rsa ]; then
        ssh-keygen -t rsa -N '' -f `pwd`/id_rsa > /dev/null
    fi
    authorized_keys=`cat $(pwd)/id_rsa.pub`

    #docker pull registry.aliyuncs.com/freshncp/logstash
    docker stop logstash 2> /dev/null
    docker rm logstash 2> /dev/null

    docker run --name logstash -d \
        -e SSH_ROOT="$authorized_keys" \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/logstash:/data \
        --link redis:redis \
        --link elasticsearch:es \
        registry.aliyuncs.com/freshncp/logstash

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如logstash.conf

    [program:logstash]
    command=/opt/logstash/bin/logstash agent -f /data/logstash.cfg
    autostart=true
    autorestart=true
    redirect_stderr=true

##logstash.cfg

    input {
      stdin {
      }
      redis {
        host => "127.0.0.1"
        port => "6379"
        key => "logstash:demo"
        data_type => "list"
        codec => "json"
        type => "logstash-redis-demo"
        tags => ["logstashdemo"]
      }
    }

    filter {
      geoip {
        source => "[extra][ip]"
        add_tag => [ "geoip" ]
      }
    }

    output {
      stdout {
        codec => rubydebug
      }
      elasticsearch {
        hosts => ["127.0.0.1:9200"]
        flush_size => 10240
      }
    }
##创建容器运行脚本run.sh

    #/bin/bash
    #docker pull registry.aliyuncs.com/freshncp/logstash
    docker stop logstash 2> /dev/null
    docker rm logstash 2> /dev/null

    docker run --name logstash -d \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/logstash:/data \
        --link redis:redis \
        --link elasticsearch:elasticsearch \
        registry.aliyuncs.com/freshncp/logstash

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如logstash.conf

    [program:logstash]
    command=/opt/logstash/bin/logstash -f /data/logstash.cfg
    autostart=true
    autorestart=true
    redirect_stderr=true

##logstash.cfg

    input {
      stdin {
      }
      redis {
        host => "a00"
        port => "6379"
        key => "events"
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
        host => "a01"
        flush_size => 10240
      }
    }
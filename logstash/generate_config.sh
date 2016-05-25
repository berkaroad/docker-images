#!/bin/sh
echo "input {
  redis {
    host => \"$REDIS_PORT_6379_TCP_ADDR\"
    port => \"$REDIS_PORT_6379_TCP_PORT\"
    key => \"logstash:demo\"
    data_type => \"list\"
    codec => \"json\"
    type => \"logstash-redis-demo\"
    tags => [\"logstashdemo\"]
  }
}

filter {
  geoip {  
    source => \"[extra][ip]\"
    add_tag => [ \"geoip\" ]
  }
}

output {
  elasticsearch {
    hosts => [\"$ES_PORT_9200_TCP_ADDR:$ES_PORT_9200_TCP_PORT\"]
    flush_size => 10240
  }
}"
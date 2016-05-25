#!/bin/sh
echo "input {
  redis {
    host => \"$REDIS_PORT_6379_TCP_ADDR\"
    port => \"$REDIS_PORT_6379_TCP_PORT\"
    key => \"events\"
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
    host => \"$ELASTICSEARCH_PORT_9300_TCP_ADDR\"
    flush_size => 10240
  }
}"
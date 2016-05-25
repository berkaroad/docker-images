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
    host => \"$ES_PORT_9300_TCP_ADDR\"
    flush_size => 10240
  }
}"
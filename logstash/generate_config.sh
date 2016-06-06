#!/bin/sh
if [ "$LOGSTASH_ROLE" = "indexer" ]; then
  echo "input {
  redis {
    host => \"$REDIS_PORT_6379_TCP_ADDR\"
    port => \"$REDIS_PORT_6379_TCP_PORT\"
    key => \"logstash:$LOGSTASH_ID\"
    data_type => \"list\"
    codec => \"json\"
    type => \"logstash-redis-$LOGSTASH_ID\"
    tags => [\"logstash\"]
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
elif [ "$LOGSTASH_ROLE" = "shipper" ]; then
  echo "input {
  http {
    host => \"0.0.0.0\"
    port => 8080
    additional_codecs => {\"application/json\"=>\"json\"}
    codec => \"plain\"
    threads => 1
    ssl => false
  }
}

filter {
  json {
    source => \"message\"
    target => \"contents\"
  }
  geoip {
    source => \"[extra][ip]\"
    add_tag => [ \"geoip\" ]
  }
}

output {
  redis {
    host => \"$REDIS_PORT_6379_TCP_ADDR:$REDIS_PORT_6379_TCP_PORT\"
    data_type => \"list\"
    key => \"logstash:$LOGSTASH_ID\"
  }
}"
fi
#!/bin/bash
set -e
if [ -n "$ES_PORT_9200_TCP_ADDR" ] && [ -n "$REDIS_PORT_6379_TCP_ADDR" ]; then
  /opt/logstash/bin/generate_config.sh > /logstash.cfg
fi

/opt/logstash/bin/logstash agent -f /logstash.cfg
#!/bin/bash
set -e
if [ -n "$ELASTICSEARCH_PORT_9300_TCP_ADDR" ] && [ -n "$REDIS_PORT_6379_TCP_ADDR" ]; then
  /opt/logstash/bin/generate_config.sh > /logstash.cfg
fi

/opt/logstash/bin/logstash -f /logstash.cfg
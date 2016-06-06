#!/bin/bash
set -e
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/config
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/logs
#gosu elasticsearch /usr/share/elasticsearch/bin/generate_elasticsearchconfig.sh > /usr/share/elasticsearch/config/elasticsearch.yml
gosu elasticsearch /usr/share/elasticsearch/bin/elasticsearch
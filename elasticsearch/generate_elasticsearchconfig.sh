#!/bin/sh
echo "cluster.name: $ELASTICSEARCH_CLUSTERNAME
cluster.routing.allocation.node_initial_primaries_recoveries: 4
cluster.routing.allocation.node_concurrent_recoveries: 2

node.name: $ELASTICSEARCH_NODENAME
node.master: true
node.data: true
node.rack: $ELASTICSEARCH_RACK

index.number_of_shards: 5
index.number_of_replicas: 1

network.host: 0.0.0.0
transport.tcp.port: 9300
transport.tcp.compress: true
http.port: 9200
http.max_content_length: 100mb
http.enabled: true

indices.recovery.max_size_per_sec: 100mb
indices.recovery.concurrent_streams: 5

discovery.zen.minimum_master_nodes: 1
discovery.zen.ping.timeout: 10s
discovery.zen.ping.multicast.enabled: true
"
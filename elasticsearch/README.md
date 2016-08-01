##创建容器运行脚本run.sh

    #/bin/bash
    #docker pull registry.aliyuncs.com/freshncp/elasticsearch
    docker stop elasticsearch 2> /dev/null
    docker rm elasticsearch 2> /dev/null

    docker run --name elasticsearch -d \
        -e ELASTICSEARCH_CLUSTERNAME="elasticsearch" \
        -e ELASTICSEARCH_NODENAME="node1" \
        -e ELASTICSEARCH_RACK="rack1" \
        -e ELASTICSEARCH_SHARDS=5 \
        -e ELASTICSEARCH_REPLICAS=1 \
        -e ELASTICSEARCH_PUBLISH_HOST="127.0.0.1" \
        -e ELASTICSEARCH_UNICAST_HOSTS="127.0.0.1:9300" \
        -e ELASTICSEARCH_HTTP_PORT=9200 \
        -e ELASTICSEARCH_TCP_PORT=9300 \
        -v `pwd`/supervisor:/supervisor \
        -v `pwd`/data/:/usr/share/elasticsearch/data \
        -v `pwd`/scripts/:/usr/share/elasticsearch/data \
        -p 9200:9200 \
        -p 9300:9300 \
        registry.aliyuncs.com/freshncp/elasticsearch

    cat `pwd`/id_rsa

##进行ssh连接

    ssh root@<docker_ip> -i id_rsa

##Supervisor

在容器目录/supervisor下添加配置文件，如elasticsearch.conf

    [program:elasticsearch]
    command=/usr/share/elasticsearch/bin/elasticsearch
    autostart=true
    autorestart=true
    redirect_stderr=true

##Elastic Search

###elasticsearch.yml

    # 配置es的集群名称，默认是elasticsearch
    cluster.name: elasticsearch
    # 初始化数据恢复时，并发恢复线程的个数
    cluster.routing.allocation.node_initial_primaries_recoveries: 4
    # 添加删除节点或负载均衡时并发恢复线程的个数
    cluster.routing.allocation.node_concurrent_recoveries: 2

    # 节点名
    node.name: node1
    # 指定该节点是否有资格被选举成为node
    node.master: true
    # 指定该节点是否存储索引数据
    node.data: true
    # 该节点所属的机架
    node.rack: rack1

    # 设置默认索引分片个数
    index.number_of_shards: 5
    # 设置默认索引副本个数
    index.number_of_replicas: 1
    # 设置为true来锁住内存。
    bootstrap.mlockall: true

    # 这个参数是用来同时设置bind_host和publish_host上面两个参数
    network.host: 0.0.0.0
    # 设置节点间交互的tcp端口
    transport.tcp.port: 9300
    # 设置是否压缩tcp传输时的数据
    transport.tcp.compress: true
    # 设置对外服务的http端口
    http.port: 9200
    # 设置内容的最大容量
    http.max_content_length: 100mb
    # 是否使用http协议对外提供服务
    http.enabled: true

    # gateway的类型，默认为local即为本地文件系统，可以设置为本地文件系统，分布式文件系统，hadoop的HDFS，和amazon的s3服务器。
    gateway.type: local
    # 设置集群中N个节点启动时进行数据恢复
    gateway.recover_after_nodes: 1
    #设置初始化数据恢复进程的超时时间
    gateway.recover_after_time: 5m
    # 设置这个集群中节点的数量
    gateway.expected_nodes: 2
    # 设置数据恢复时限制的带宽
    indices.recovery.max_size_per_sec: 100mb
    # 设置这个参数来限制从其它分片恢复数据时最大同时打开并发流的个数
    indices.recovery.concurrent_streams: 5

    # 设置这个参数来保证集群中的节点可以知道其它N个有master资格的节点
    discovery.zen.minimum_master_nodes: 1
    # 设置集群中自动发现其它节点时ping连接超时时间
    discovery.zen.ping.timeout: 10s
    # 设置是否打开多播发现节点
    discovery.zen.ping.multicast.enabled: true
    discovery.zen.ping.unicast.hosts: ["192.168.1.231:9300"]
    # 备份路径
    path.repo: ["/usr/share/elasticsearch/backups"]
#!/bin/bash
set -e

#sysctl vm.overcommit_memory=1
#echo never > /sys/kernel/mm/transparent_hugepage/enabled
#echo 512 > /proc/sys/net/core/somaxconn
chown -R redis /data
exec gosu redis redis-server $@
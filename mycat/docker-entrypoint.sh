#!/bin/bash
set -e

if [ `ls /opt/mycat/conf | wc -l` -eq 0 ]; then
	cp -R /opt/mycat/conf.defaults/* /opt/mycat/conf/
fi
chmod 0600 /opt/mycat/conf/*
exec /opt/mycat/bin/mycat console
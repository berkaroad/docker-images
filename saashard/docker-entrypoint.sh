#!/bin/bash
set -e

if [ `ls /opt/saashard/conf | wc -l` -eq 0 ]; then
	cp -R /opt/saashard/conf.defaults/* /opt/saashard/conf/
fi
chmod 0600 /opt/saashard/conf/*
exec /opt/saashard/bin/saashard -config /opt/saashard/conf/ss.yaml
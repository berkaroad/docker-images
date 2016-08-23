#!/bin/bash
set -e

if [ `ls /opt/kingshard/conf | wc -l` -eq 0 ]; then
	cp -R /opt/kingshard/conf.defaults/* /opt/kingshard/conf/
fi
chmod 0600 /opt/kingshard/conf/*
exec /opt/kingshard/bin/kingshard -config /opt/kingshard/conf/ks.yaml
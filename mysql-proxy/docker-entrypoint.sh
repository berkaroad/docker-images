#!/bin/bash
set -e
chown -R mysql:mysql /var/lib/mysql-proxy
chown -R mysql:mysql /var/log/mysql-proxy
chmod 0660 $MYSQL_PROXY_CNF
exec mysql-proxy --defaults-file=$MYSQL_PROXY_CNF $@
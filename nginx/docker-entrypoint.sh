#!/bin/bash
set -e
if [ "$1" = 'nginx' ]; then
        chown -R www-data .
        #exec gosu www-data "$@"
	exec "$@"
fi

exec "$@"

#!/bin/bash
set -e
ls /supervisor/*.conf 2>dev/null | grep conf | xargs -i cp {} /etc/supervisor/conf.d
exec "$@"

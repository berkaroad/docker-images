#!/bin/bash
set -e
echo $SSH_AUTHORIZED_KEYS > /root/.ssh/authorized_keys
ls /supervisor/*.conf 2>dev/null | grep conf | xargs -i cp {} /etc/supervisor/conf.d
exec "$@"

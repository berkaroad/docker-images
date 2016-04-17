#!/bin/bash
set -e
echo $SSH_AUTHORIZED_KEYS > /root/.ssh/authorized_keys
cp -Rf /supervisor/*.conf /etc/supervisor/conf.d/
exec "$@"

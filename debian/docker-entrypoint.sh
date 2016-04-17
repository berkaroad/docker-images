#!/bin/bash
set -e
echo $SSH_AUTHORIZED_KEYS > /root/.ssh/authorized_keys
exec "$@"

#!/bin/bash
set -e
echo $SSH_ROOT > /root/.ssh/authorized_keys
exec "$@"

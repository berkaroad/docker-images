#!/bin/bash
set -e
ROOT=/opt/selenium
CONF=$ROOT/config.json

$ROOT/generate_config > $CONF
echo "starting selenium hub with configuration:"
cat $CONF

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

function shutdown {
    echo "shutting down hub.."
    kill -s SIGTERM $NODE_PID
    wait $NODE_PID
    echo "shutdown complete"
}

java ${JAVA_OPTS} -jar /opt/selenium/selenium-server-standalone.jar \
  -role hub \
  -hubConfig $CONF \
  ${SE_OPTS}

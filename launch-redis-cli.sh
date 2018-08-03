#!/bin/bash
set -e

declare HOST=${HOST}
declare PORT=${PORT:-6379}
declare PASS=${PASS:-}

if [[ -z "$HOST" ]]; then
    echo "Usage: docker run -it -e HOST=host -e PORT=port -e PASS=password rnandiki/redis-cli-ssl"
    exit 1
fi

if [[ -n "$1" ]]; then
    exec "$@"
else

    cat <<END > /stunnel4.conf
    client = yes
    foreground = no
    debug = warning
    pid = /tmp/stunnel.pid
    output = /tmp/stunnel.log
    [redis]
    accept = 127.0.0.1:6379
    connect = ${HOST}:${PORT}
END
    /usr/bin/stunnel4 /stunnel4.conf
    /usr/local/bin/redis-cli -h localhost -p 6379 -a "$PASS"
fi

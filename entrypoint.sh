#!/bin/sh

set -e

case "$1" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@" ;;
esac

# From https://stackoverflow.com/questions/12264238/restart-process-on-file-change-in-linux

sigint_handler()
{
  kill $PID
  exit
}

trap sigint_handler SIGINT

while true; do
  exec "$@" &
  PID=$!
  inotifywait -e modify -e move -e create -e delete -e attrib -r $REGISTRY_HTTP_TLS_CERTIFICATE
  kill $PID
done



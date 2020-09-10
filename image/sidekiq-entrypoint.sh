#!/bin/sh

set -e

bundle exec prometheus_exporter -p 9394 -b 0.0.0.0 -t 1 &

cd /app

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec sidekiq -C /app/config/sidekiq.yml

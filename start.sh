#!/bin/bash
rm -f app/tmp/pids/server.pid
rm -f app/tmp/pids/test.pid
rm -f app/tmp/pids/dev.pid

docker-compose up -d

#!/bin/bash

docker exec -it rails bundle exec rake environment elasticsearch:import:all FORCE=y


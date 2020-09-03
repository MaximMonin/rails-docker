#!/bin/bash

#docker exec -it rails rails db:setup RAILS_ENV=test
#docker exec -it rails rails db:fixtures:load RAILS_ENV=test
docker exec -it rails rails test:system

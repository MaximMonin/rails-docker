#!/bin/bash

docker rm -f rails
docker run -d -v $(pwd)/tmp:/tmp --name rails maximmonin/rails
docker exec -i rails cp -R /app /tmp
docker rm -f rails
mv $(pwd)/tmp/app .
rm -r tmp
docker run -d -v $(pwd)/app:/app --name rails maximmonin/rails
docker exec -i rails chown -R www-data:www-data /app/storage /app/public
docker exec -i rails chmod -R a+rw /app/storage /app/public
docker rm -f rails
chmod -R a+rw app


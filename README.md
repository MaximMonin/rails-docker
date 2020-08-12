# rails-docker
Ruby on Rails 6.x in Docker

DockerFile + Docker-compose file to setup Ruby on Rails enviroment.
Includes Selenium Browser test setup, Postgres DB adminer, Sidekiq server

## Installation
1. Build rails Image. Use build.sh. You can use docker pull maximmonin/rails instead.   
2. Run prepare.sh to extract rails app directory from rails docker image to ./app   
3. Copy .env-example to .env and change to your site   
4. Start containters start.sh   
5. Postgres db will be created on first run.   

Run run_tests.sh to run rails test   
Run run_tests_system.sh to run system browser tests through selenium   
Run run_webpack.sh to compile java scripts with webpack   
Run run_precompile.sh to precompile assets for production use   

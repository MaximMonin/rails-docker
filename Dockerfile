FROM ruby:2.7

#Install Nodejs + Yarn + db-clients
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \ 
    && apt-get update \
    && apt install nodejs sqlite3 postgresql-client mariadb-client libmariadb-dev -y --no-install-recommends \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install yarn \      
    && rm -rf /var/lib/apt/lists/*
                
WORKDIR /

#Install Ruby On Rails
RUN gem install mysql2 pg rails && rails new app --webpack=vue -d postgresql
WORKDIR /app

RUN echo "gem 'sidekiq', '>= 6'" >> Gemfile \
    && echo "gem 'redis', '>= 4'" >> Gemfile \
    && bundle install

COPY image/sidekiq-entrypoint.sh /
COPY image/database.yml /app/config/


EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

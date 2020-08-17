FROM ruby:2.7

#Install Nodejs + Yarn + db-clients + ffmpeg
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \ 
    && apt-get update \
    && apt install nodejs sqlite3 postgresql-client mariadb-client libmariadb-dev ffmpeg -y --no-install-recommends \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install yarn \
    && rm -rf /var/lib/apt/lists/*
                
WORKDIR /

#Install Ruby On Rails
RUN gem install mysql2 pg rails && rails new app --webpack=vue -d postgresql --skip-turbolinks \
    && rm -f /app/app/javascript/packs/hello_vue.js /app/app/javascript/app.vue

WORKDIR /app

RUN    echo "\n#######################################################################" >> Gemfile \
    && echo "# Rails addon gems" >> Gemfile \
    && echo "# Job processing, auth, pagination, image/video processing," >> Gemfile \
    && echo "# simple-forms, sms, file upload, file storage, localization" >> Gemfile \
    && echo "#######################################################################" >> Gemfile \
    && echo "gem 'sidekiq', '>= 6'" >> Gemfile \
    && echo "gem 'devise'" >> Gemfile \
    && echo "gem 'jwt_sessions'" >> Gemfile \
    && echo "gem 'rack-cors'" >> Gemfile \
    && echo "gem 'will_paginate', '>= 3'" >> Gemfile \
    && echo "gem 'image_processing', '~> 1.2'" >> Gemfile \
    && echo "gem 'streamio-ffmpeg', '>= 2'" >> Gemfile \
    && echo "gem 'simple_form'" >> Gemfile \
    && echo "gem 'turbosms'" >> Gemfile \
    && echo "gem 'dotenv-rails'" >> Gemfile \
    && echo "gem 'carrierwave', '>= 2.0'" >> Gemfile \
    && echo "gem 'aws-sdk-s3'" >> Gemfile \
    && echo "gem 'activestorage-sftp'" >> Gemfile \
    && echo "gem 'rails-i18n', '~> 6.0.0'" >> Gemfile \
    && echo "gem 'carrierwave-i18n'" >> Gemfile \
    && echo "gem 'devise-i18n'" >> Gemfile \
    && echo "gem 'will-paginate-i18n'" >> Gemfile \
    && echo "\ngroup :development, :test do" >> Gemfile \
    && echo "  gem 'faker'" >> Gemfile \
    && echo "end" >> Gemfile \
    && bundle install \
    && rails generate simple_form:install --bootstrap \
    && rails generate devise:install && rails generate devise:i18n:views \
    && rails active_storage:install

RUN sed -i -- 's!Rails.application.configure do!Rails.application.configure do\n  config.hosts.clear!' config/environments/development.rb \
    && sed -i -- 's!Rails.application.configure do!Rails.application.configure do\n  config.hosts.clear!' config/environments/test.rb

COPY image /

RUN yarn add bootstrap jquery popper.js dropzone vue-router bootstrap-vue vuex axios

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

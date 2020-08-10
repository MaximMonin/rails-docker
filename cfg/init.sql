CREATE DATABASE rails_dev;
CREATE DATABASE rails_test;
CREATE DATABASE rails;

CREATE USER rails PASSWORD 'rails';
GRANT ALL PRIVILEGES ON DATABASE rails_dev, rails_test, rails TO rails;
ALTER USER rails CREATEDB;
ALTER DATABASE rails_dev owner to rails;
ALTER DATABASE rails_test owner to rails;
ALTER DATABASE rails owner to rails;

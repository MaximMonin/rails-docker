CREATE DATABASE rails_dev ENCODING = 'unicode';
CREATE DATABASE rails_test ENCODING = 'unicode';
CREATE DATABASE rails ENCODING = 'unicode';

CREATE USER rails PASSWORD 'rails';
GRANT ALL PRIVILEGES ON DATABASE rails_dev, rails_test, rails TO rails;
ALTER USER rails CREATEDB REPLICATION;
ALTER DATABASE rails_dev owner to rails;
ALTER DATABASE rails_test owner to rails;
ALTER DATABASE rails owner to rails;
ALTER USER rails WITH SUPERUSER;

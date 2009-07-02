# create local development database.yml
file 'config/database.yml',
%q{development:
  adapter: mysql
  encoding: utf8
  reconnect: false
  database: APP_NAME_development
  pool: 5
  username: root
  password:
  socket: /opt/local/var/run/mysql5/mysqld.sock

test:
  adapter: mysql
  encoding: utf8
  reconnect: false
  database: APP_NAME_test
  pool: 5
  username: root
  password:
  socket: /opt/local/var/run/mysql5/mysqld.sock
  
staging:
  development

production:
  development}.gsub('APP_NAME', @app_name)
  
rake 'db:create:all'
rake 'db:migrate'

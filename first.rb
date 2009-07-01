# remove tmp dirs
run "rmdir tmp/{ pids, sessions, sockets, cache }"
 
# remove unnecessary stuff
run "rm README log/*.log public/index.html public/images/rails.png"
 
# basic .gitignore file
file '.gitignore', 
%q{log/*.log
log/*.pid
db/*.db
db/*.sqlite3
tmp/**/*
.DS_Store
*.tmproj
doc/api
doc/app
config/database.yml
autotest_result.html
coverage
public/javascripts/*_[0-9]*.js
public/stylesheets/*_[0-9]*.css
public/attachments
}
 
# copy sample database config
run "cp config/database.yml config/database.yml.sample"

# copy production environment to staging
run "cp config/environments/production.rb config/environments/staging.rb"
# remove tmp dirs
run "rmdir tmp/{ pids, sessions, sockets, cache }"
 
# remove unnecessary stuff
run "rm README log/*.log public/favicon.ico public/index.html public/images/rails.png public/robots.txt"
 
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

# rename README.md
file 'README.md', "TODO\n\n"

# create application initializer
file 'config/initializers/application.rb',
%q{class Hash #:nodoc:
  def method_missing(key, *args)
    return nil if !self[key] && !self[key.to_s]
    self[key] || self[key.to_s]
  end
end

class Object #:nodoc:
  # @person.try(:name)
  def try(method)
    send method if respond_to? method
  end
end
}

file 'config/initializers/smtp.rb',
%q{config.action_mailer.smtp_settings = {
  :address => # ADDRESS,
  :port => 25,
  :domain => # DOMAIN,
  :authentication => :login,
  :user_name => # USERNAME,
  :password => # PASSWORD
}}

open('README.md', 'a') { |f|
  f.puts "Add credentials (username, password etc.) to 'config/initializers/smtp.rb'"
}

# create requires initializer
file 'config/initializers/requires.rb', ''
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
config/passwords.yml
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

# create requires initializer
file 'config/initializers/requires.rb', ''

# create smtp initializer
file 'config/initializers/smtp.rb',
%q{f = "config/passwords.yml"
abort "Couldn't find #{f}" unless File.exists?(f)
passwords = YAML::load(File.open(f))

ActionMailer::Base.smtp_settings = {
  :address => 'ADDRESS',
  :port => 25,
  :domain => 'DOMAIN',
  :authentication => :login,
  :user_name => passwords['smtp']['user'],
  :password => passwords['smtp']['password']
}}

# append TODO
open('README.md', 'a') { |f|
  f.puts "Add SMTP address and domain to 'config/initializers/smtp.rb'"
}

# create passwords.example.yml
file 'config/passwords.example.yml',
%q{scm:
  user: USER
  password: PASSWORD

smtp:
  user: USER
  password: PASSWORD
  
staging:
  user: USER
  password: PASSWORD
  
production:
  user: USER
  password: PASSWORD}
  
# copy passwords.example.yml to passwords.yml (ignored)
run "cp config/passwords.example.yml config/passwords.yml"

# append TODO
open('README.md', 'a') { |f|
  f.puts "Add users and passwords to 'config/passwords.yml'"
}
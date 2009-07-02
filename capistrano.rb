capify!

# replace deploy.rb
file 'config/deploy.rb',
%q{set :stages, %w(production staging)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'

set :app_name, 'APP_NAME'
set :keep_releases, 5
set :ln, "/usr/xpg4/bin/ln"
set :mongrel_rails, "/usr/local/bin/mongrel_rails"
set :rake, "/usr/local/bin/rake"

default_run_options[:pty] = true
set :branch, 'master'
set :repository,  "git@github.com:robbevan/APP_NAME.git"
set :scm, 'git'
set :deploy_via, :remote_cache
set :git_enable_submodules, true
ssh_options[:forward_agent] = true

f = "config/passwords.yml"
unless File.exists?(f)
  abort "Couldn't find config/passwords.yml"
end
set :passwords, YAML::load(File.open(f))
set :scm_passphrase, passwords['scm']['password']

namespace :deploy do
  task :after_update_code, :roles => [:app] do
    run "#{ln} -s #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
    run "#{ln} -s #{shared_path}/config/passwords.yml #{release_path}/config/passwords.yml" 
  end
end}.gsub('APP_NAME', @app_name)

# append TODO
open('README.md', 'a') { |f|
  f.puts "Check repository etc. in 'config/deploy.rb'"
}

# create production.rb
file 'config/deploy/production.rb',
%q{role :app, 'APP_NAME.tld'
role :db,  'APP_NAME.tld', :primary => true

set :deploy_to, "/path/to/domains/#{app_name}.tld/apps/#{app_name}"
set :svcadm, "/usr/sbin/svcadm"
set :rails_env, "production"
set :user, passwords['production']['user']

namespace :deploy do
  task :after_update_code, :roles => [:app] do
    run "#{ln} -s #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
    run "#{ln} -s #{shared_path}/config/mongrel_cluster.yml #{release_path}/config/mongrel_cluster.yml" 
    run "#{ln} -s #{shared_path}/config/passwords.yml #{release_path}/config/passwords.yml" 
  end

  task :stop, :roles => [:app] do
    send(run_method, "#{svcadm} disable #{app_name}-prod")
  end

  task :start, :roles => [:app] do
    send(run_method, "#{svcadm} enable #{app_name}-prod")
  end
  
  task :restart, :roles => [:app] do
    send(run_method, "#{svcadm} restart #{app_name}-prod")
  end
end}.gsub('APP_NAME', @app_name)

# append TODO
open('README.md', 'a') { |f|
  f.puts "Update .tld and paths etc. in 'config/deploy/production.rb'"
}

# create staging.rb
file 'config/deploy/staging.rb',
%q{role :app, 'staging.APP_NAME.tld'
role :db,  'staging.APP_NAME.tld', :primary => true

set :app_port, "9000"
set :branch, "#{`git branch`.scan(/^\* (\S+)/)}"
set :deploy_to, "/path/to/domains/staging.#{app_name}.tld/apps/#{app_name}"
set :rails_env, "staging"
set :user, passwords['staging']['user']
set :use_sudo, false

namespace :deploy do
  task :stop, :roles => [:app] do
    send(run_method, "cd #{current_path} && #{mongrel_rails} stop")
  end

  task :start, :roles => [:app] do
    send(run_method, "cd #{current_path} && #{mongrel_rails} start -d -p #{app_port} -e #{rails_env}")
  end
  
  task :restart, :roles => [:app] do
    stop
    start
  end
end}.gsub('APP_NAME', @app_name)

# append TODO
open('README.md', 'a') { |f|
  f.puts "Update .tld and paths etc. in 'config/deploy/staging.rb'"
}
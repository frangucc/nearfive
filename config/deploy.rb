#require "delayed/recipes"
require './config/boot'
require "bundler/capistrano"
set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require "rvm/capistrano"
# Load RVM's capistrano plugin.
load "deploy/assets"

set :rvm_ruby_string, 'ruby-1.9.3-p194@nearfive'
#set :rvm_type, :deploy

set :application,     "nearfive"
set :keep_releases,   10

set :scm,           :git
set :repository,    "git@github.com:frangucc/nearfive.git"
set :branch,        "master"
set :deploy_via,    :remote_cache
set :git_shallow_clone, 1


role :web, "198.101.206.122"                          # Your HTTP server, Apache/Nginx/etc
role :app, "198.101.206.122"                          # This may be the same as your `Web` server
role :db,  "198.101.206.122", :primary => true        # This is where Rails migrations will run

set :user,          "deploy"
set :use_sudo,      false
ssh_options[:forward_agent] = true

task :production do
  set :rails_env,   "production"
  set :application, 'nearfive_production'
  set :deploy_to,   "/home/deploy/website/nearfive/production"
end


task :staging do
  set :rails_env,   "staging"
  set :application, 'nearfive_staging'
	set :deploy_to,   "/home/deploy/website/nearfive/staging"
end


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    #run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :seed, :roles => :db do
    run("cd #{deploy_to}/current && /home/deploy/.rvm/gems/ruby-1.9.3-p194@global/bin/rake db:seed RAILS_ENV=#{rails_env}")  
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && /home/deploy/.rvm/gems/ruby-1.9.3-p194@global/bin/rake RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end  

end


desc "Run a task on a remote server. cap staging rake:invoke task=blah"  
# run like: cap staging invoke_rake task=a_certain_task  
task :invoke_rake do  
  run("cd #{deploy_to}/current && /home/deploy/.rvm/gems/ruby-1.9.3-p194@global/bin/rake #{ENV['task']} RAILS_ENV=#{rails_env}")  
end  


task :symlink_database_and_system_folder do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
before  "deploy:assets:precompile",     "symlink_database_and_system_folder"
after   "deploy:setup", "symlink_database_and_system_folder"

## For delayed_job
##after "deploy:stop",    "delayed_job:stop"
#after "deploy:start",   "rake:recompile_assest"
#after "deploy:restart", "rake:recompile_assest"
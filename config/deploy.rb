require 'bundler/capistrano'

default_run_options[:pty] = true

set :application, "china_where"
set :repository, 'git@github.com:chinawhere/chinawhere.git'
set :deploy_to, "/home/developer/#{application}"
set :keep_releases, 3

set :use_sudo, false

set :user, "developer"

server "106.187.91.138", :web, :app, :db, primary: true

namespace :deploy do
  before "deploy", "deploy:check_revision"
  after "deploy", "deploy:restart_unicorn"
  after "deploy:restart_unicorn", "deploy:migrate_db"
  after 'deploy:restart', 'deploy:cleanup'
  task :restart_unicorn, roles: :web do
    puts "stop the running unicorn process"
    run "cd #{current_path} && bundle exec rake unicorn:stop"
    puts "run the new unicorn process"
    run "cd #{current_path} && bundle exec rake unicorn:run"
  end
  task :migrate_db, roles: :web do
    run "cd #{current_path} && bundle exec rake db:migrate"
  end
  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    remote = `git remote`.strip
    unless `git rev-parse HEAD` == `git rev-parse #{remote}/master`
      puts "WARNING: HEAD is not the same as #{remote}/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
end

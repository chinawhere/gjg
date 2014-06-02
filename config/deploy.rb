require 'bundler/capistrano'

default_run_options[:pty] = true

set :application, "china_where"
set :repository, 'git@github.com:chinawhere/chinawhere.git'
set :deploy_to, "/home/developer/#{application}"

set :use_sudo, false

set :user, "developer"

server "106.187.91.138", :web, :app, :db, primary: true

namespace :deploy do
  before "deploy", "deploy:check_revision"
  after "deploy", "deploy:restart_unicorn"
  after "deploy:restart_unicorn", "deploy:migrate_db"
  # after "deploy:restart_unicorn", "deploy:reload_nginx"
  # before "deploy", "deploy:stop_unicorn"
  # after "deploy", "deploy:run_unicorn"
  # desc "stop unicorn server"
  # task :stop_unicorn, roles: :web 
  task :restart_unicorn, roles: :web do
    puts "stop the running unicorn process"
    run "cd #{current_path} && bundle exec rake unicorn:stop"
    puts "run the new unicorn process"
    run "cd #{current_path} && bundle exec rake unicorn:run"
  end
  task :migrate_db, roles: :web do
    run "cd #{current_path} && bundle exec rake db:migrate"
  end
  # task :link_nginx, roles: :web do

  # end

  # task :setup_config, roles: :app do
  #   sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
  #   sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  #   run "mkdir -p #{shared_path}/config"
  #   put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
  #   puts "Now edit the config files in #{shared_path}."
  # end
  # after "deploy:setup", "deploy:setup_config"
  # task :symlink_config, roles: :app do
  #   run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  # end
  # after "deploy:finalize_update", "deploy:symlink_config"
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

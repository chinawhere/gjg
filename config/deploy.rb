require 'bundler/capistrano'
set :application, "china_where"
set :repository, 'git@github.com:chinawhere/chinawhere.git'
set :deploy_to, "/tmp/#{application}"

set :user, "root"

server "106.187.91.138", :web, :app, :db, primary: true

namespace :deploy do
  before "deploy", "deploy:stop_unicorn"
  before "deploy", "deploy:run_unicorn"
  desc "stop unicorn server"
  task :stop_unicorn, roles: :web do
    run "cd #{current_path} && bundle exec rake unicorn:stop"
  end
  desc "run unicorn server"
  task :run_unicorn, roles: :web do
    run "cd #{current_path} && bundle exec rake unicorn:run"
  end
  # namespace :unicorn_run do
  #   desc "run unicorn server"
  #   task :run, roles: :web do
  #     run "cd #{current_path} && rake unicorn:start"
  #   end
  # end
  # %w[run stop].each do |command|
  #   desc "#{command} unicorn server"
  #   task command.to_sym do
  #     run "cd #{current_path} ; rake unicorn:#{command}"
  #   end
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
  # desc "Make sure local git is in sync with remote."
  # task :check_revision, roles: :web do
  #   unless `git rev-parse HEAD` == `git rev-parse origin/master`
  #     puts "WARNING: HEAD is not the same as origin/master"
  #     puts "Run `git push` to sync changes."
  #     exit
  #   end
  # end
  # before "deploy", "deploy:check_revision"
  # before "deploy", "deploy:check_revision"
end

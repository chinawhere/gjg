# require 'mina/puma'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)

set :user, "root"
set :domain, "123.56.102.78"

set :deploy_to, "/opt/project/chinawhere"
set :repository, '/opt/project/chinawhere.git'
set :branch, 'master'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log']

desc "Push repository to the remote server"
task :before_clone do
  system "git add . -A"
  system "git commit -m '#{Time.now.to_s}'"
  system "git push chinawhere #{branch}"
end

desc "run db:seed"
task :db_seed do
  queue 'bundle exec rake db:seed'
end

task :environment do
  invoke :'rbenv:load'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :before_clone
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    queue! "RAILS_ENV=production bundle"
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue! "RAILS_ENV=production bundle exec rake restart_puma"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers


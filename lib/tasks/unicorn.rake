# coding: utf-8
namespace :unicorn do
  desc 'stat unicorn'
  task :run do 
    Dir.chdir File.join(Rails.root)
    system 'bundle exec unicorn -c config/unicorn.rb -E production -D -p 3000'
  end
  desc 'stop unicorn'
  task :stop do
    system "kill -9 `cat /tmp/unicorn.pid`"
  end
end

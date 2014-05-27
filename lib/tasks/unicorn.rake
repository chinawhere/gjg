namespace :unicorn do
  desc 'stat unicorn'
  task :run do 
    Dir.chdir File.join(Rails.root)
    system 'bundle exec unicorn -c config/unicorn.rb -E development -D -p 3001'
  end
  desc 'stop unicorn'
  task :stop do
    Dir.chdir File.join(Rails.root, 'tmp', 'pids')
    system "kill -9 `cat unicorn.pid`"
  end
end

desc 'restart puma'
task :restart_puma => :environment do
  system "kill `cat /home/developer/chinawhere/tmp/puma.pid`"
  Dir.chdir "/home/developer/chinawhere/current"
  system "puma -C config/puma.rb"
end
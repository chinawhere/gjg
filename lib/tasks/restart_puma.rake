desc 'restart puma'
task :restart_puma => :environment do
  system "kill `cat /opt/project/chinawhere/tmp/puma.pid`"
  Dir.chdir "/opt/project/chinawhere/current"
  system "puma -C config/puma.rb"
end
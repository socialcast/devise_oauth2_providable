begin
  require 'bundler'
rescue LoadError
  STDERR.puts "bundler not found - use gem install bundler to install it"
  exit 1
end

Bundler.setup
Bundler::GemHelper.install_tasks

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')
task :default => :spec

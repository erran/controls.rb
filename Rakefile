require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = "--require ./spec/spec_helper.rb --format documentation --color"
end

task :default => :spec

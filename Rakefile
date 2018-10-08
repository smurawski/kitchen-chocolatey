# -*- encoding: utf-8 -*-

require "bundler/gem_tasks"

require "rake/testtask"
Rake::TestTask.new(:unit) do |t|
  t.libs.push "lib"
  t.test_files = FileList["spec/**/*_spec.rb"]
  t.verbose = true
end

desc "Run all test suites"
task :test => [:unit]

task :default => [:test]

begin
  require "github_changelog_generator/task"
  require 'kitchen-chocolatey/version'

  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.future_release = "v#{Kitchen::Chocolatey::VERSION}"
    config.issues = false
    config.pulls = true
    config.user = 'test-kitchen'
    config.project = 'kitchen-chocolatey'
  end
rescue LoadError
  puts "github_changelog_generator is not available. " \
    "gem install github_changelog_generator to generate changelogs"
end

# encoding: utf-8

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "kitchen-chocolatey/version"

Gem::Specification.new do |s|
  s.name              = "kitchen-chocolatey"
  s.version           = Kitchen::Chocolatey::VERSION
  s.authors           = ["Steven Murawski"]
  s.email             = ["steven.murawski@gmail.com"]
  s.homepage          = "https://github.com/smurawski/kitchen-chocolatey"
  s.summary           = "Chocolatey provisioner for test-kitchen"
  candidates          = Dir.glob("lib/**/*") + ["README.md", "kitchen-chocolatey.gemspec"]
  s.files             = candidates.sort
  s.platform          = Gem::Platform::RUBY
  s.require_paths     = ["lib"]
  s.rubyforge_project = "[none]"
  s.license           = "Apache 2"
  s.description       = <<-EOF
== DESCRIPTION:

Chocolatey Provisioner for Test Kitchen

== FEATURES:

TBD

EOF
  s.add_dependency "test-kitchen", ">= 1.9"

  s.add_development_dependency "countloc", "~> 0.4"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec",     "~> 3.2"
  s.add_development_dependency "simplecov", "~> 0.9"
  s.add_development_dependency "minitest",  "~> 5.3"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-stack_explorer"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "rb-readline"
end

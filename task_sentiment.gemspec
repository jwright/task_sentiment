# frozen_string_literal: true

require File.expand_path(
  File.join("..", "lib", "task_sentiment", "version"),
  __FILE__
)

Gem::Specification.new do |s|
  s.name        = "task_sentiment"
  s.version     = TaskSentiment::VERSION
  s.authors     = ["Jamie Wright"]
  s.email       = ["jamie@brilliantfantastic.com"]
  s.homepage    = "https://github.com/jwright/task_sentiment"
  s.description = %(A classifier for task phrases)
  s.summary     = %(A classifier to parse phrases and classify the parts of a task such as the description, due date, and assignees.)
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2")

  s.add_dependency "ruby-openai", "~> 1.3.1"

  s.add_development_dependency "rake", "> 10.0.0"
end

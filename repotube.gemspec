# frozen_string_literal: true

require_relative "lib/repotube"

Gem::Specification.new do |spec|
  spec.name          = "repotube"
  spec.version       = RepoTube::VERSION
  spec.authors       = ["Karl Stolley"]
  spec.email         = ["karl.stolley@gmail.com"]
  spec.homepage      = "https://github.com/karlstolley/repotube"
  spec.license       = "MIT"

  spec.summary       = "YouTube time-marked URLs from Git commit timestamps"
  spec.description   = "Ruby CLI app to generate YouTube time-markers from the timestamps of Git commits."

  spec.metadata      = {
    "bug_tracker_uri" => "https://github.com/karlstolley/repotube/issues",
    "changelog_uri"   => "https://github.com/karlstolley/repotube/releases",
    "documentation_uri" => "https://github.com/karlstolley/repotube/README.md",
    "homepage_uri"    => spec.homepage,
    "source_code_uri" => "https://github.com/karlstolley/repotube"
  }

  all_files = Dir.glob("**/*")
  spec.files = all_files.grep(%r{^(Gemfile|exe|lib)}i)
  spec.bindir = "exe"
  spec.executables = ["repotube"]

  spec.required_ruby_version = "~> 2.6"

  spec.add_runtime_dependency "mercenary", "~> 0.4"

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", "~> 12.3"
end

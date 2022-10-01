# frozen_string_literal: true

require_relative "lib/datadog_thread_tracer/version"

Gem::Specification.new do |spec|
  spec.name = "datadog_thread_tracer"
  spec.version = DatadogThreadTracer::VERSION
  spec.authors = ["sue445"]
  spec.email = ["sue445@sue445.net"]

  spec.summary = "ddtrace helper to collect traces in thread"
  spec.description = "ddtrace helper to collect traces in thread"
  spec.homepage = "https://github.com/sue445/datadog_thread_tracer"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://sue445.github.io/datadog_thread_tracer/"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features|img)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ddtrace", ">= 1.0.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop_auto_corrector"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "yard"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

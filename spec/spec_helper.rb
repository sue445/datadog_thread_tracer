# frozen_string_literal: true

require "datadog_thread_tracer"
require "webmock/rspec"

Datadog.configure do |c|
  c.service = "datadog_thread_tracer"

  # Suppress all datadog logging
  c.logger.level = Logger::FATAL

  # c.runtime_metrics.enabled = true
  # c.profiling.enabled = true

  # Tracing settings
  # c.tracing.analytics.enabled = true
  # c.tracing.partial_flush.enabled = true
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end

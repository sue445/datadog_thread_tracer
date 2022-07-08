# frozen_string_literal: true

require "ddtrace"

require_relative "datadog_thread_tracer/version"
require_relative "datadog_thread_tracer/tracer"

module DatadogThreadTracer # rubocop:disable Style/Documentation
  class Error < StandardError; end

  # @yield
  # @yieldparam [DatadogThreadTracer::Tracer] tracer
  def self.trace
    Datadog::Tracing.trace("DatadogThreadTracer.trace") do
      tracer = DatadogThreadTracer::Tracer.new

      yield tracer

      tracer.join_threads
    end
  end
end

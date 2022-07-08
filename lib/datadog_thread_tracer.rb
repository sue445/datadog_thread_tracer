# frozen_string_literal: true

require "ddtrace"

require_relative "datadog_thread_tracer/version"
require_relative "datadog_thread_tracer/thread_tracer"

module DatadogThreadTracer # rubocop:disable Style/Documentation
  class Error < StandardError; end

  DEFAULT_TRACE_NAME = "DatadogThreadTracer.trace"

  # @param trace_name [String]
  # @yield Processes you want to execute in a thread
  # @yieldparam [DatadogThreadTracer::ThreadTracer] thread_tracer
  def self.trace(trace_name = DEFAULT_TRACE_NAME)
    Datadog::Tracing.trace(trace_name) do
      thread_tracer = DatadogThreadTracer::ThreadTracer.new

      yield thread_tracer

      thread_tracer.join_threads
    end
  end
end

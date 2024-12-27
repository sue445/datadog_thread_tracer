# frozen_string_literal: true

require "datadog"

require_relative "datadog_thread_tracer/version"
require_relative "datadog_thread_tracer/thread_tracer"

module DatadogThreadTracer # rubocop:disable Style/Documentation
  class Error < StandardError; end

  DEFAULT_TRACE_NAME = "DatadogThreadTracer.trace"

  # @param trace_name [String]
  # @yield Processes you want to execute in a thread
  # @yieldparam [DatadogThreadTracer::ThreadTracer] t
  #
  # @example
  #   DatadogThreadTracer.trace do |t|
  #     t.trace do
  #       # do something. (this block is called in thread)
  #     end
  #   end
  #
  def self.trace(trace_name = DEFAULT_TRACE_NAME)
    Datadog::Tracing.trace(trace_name) do
      t = DatadogThreadTracer::ThreadTracer.new

      yield t

      t.join_threads
    end
  end
end

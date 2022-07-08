# frozen_string_literal: true

module DatadogThreadTracer
  # trace within threads
  class ThreadTracer
    def initialize
      @threads = []
      @thread_count = 0
    end

    # @param trace_name [String]
    # @yield Processes you want to execute in a thread
    def trace(trace_name = nil, &block)
      @thread_count += 1
      trace_name ||= "thread_#{@thread_count}"

      # c.f. https://github.com/DataDog/dd-trace-rb/issues/1460
      tracer = Datadog::Tracing.send(:tracer)

      @threads << Thread.start(trace_name, tracer.provider.context) do |name, context|
        tracer = Datadog::Tracing.send(:tracer)

        tracer.provider.context = context
        Datadog::Tracing.trace(name, &block)
      end
    end

    def join_threads
      @threads.each(&:join)
    end
  end
end

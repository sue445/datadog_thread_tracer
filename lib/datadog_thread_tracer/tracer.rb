module DatadogThreadTracer
  class Tracer
    def initialize
      @threads = []
      @thread_count = 0
    end

    # @param trace_name [String]
    # @yield
    def trace(trace_name = nil, &block)
      @thread_count += 1
      trace_name ||= "thread_#{@thread_count}"

      # c.f. https://github.com/DataDog/dd-trace-rb/issues/1460
      tracer = Datadog::Tracing.send(:tracer)

      context = tracer.provider.context
      @threads << Thread.start(trace_name, context) do |trace_name, context|
        tracer = Datadog::Tracing.send(:tracer)

        tracer.provider.context = context
        Datadog::Tracing.trace(trace_name, &block)
      end
    end

    def join_threads
      @threads.each(&:join)
    end
  end
end

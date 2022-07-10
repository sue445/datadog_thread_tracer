# frozen_string_literal: true

module DatadogThreadTracer
  # trace within threads
  class ThreadTracer
    def initialize
      @threads = []
      @thread_count = 0
    end

    # @param trace_name [String]
    # @param thread_args [Array,Object] Passed to `Thread.start`
    # @yield Processes you want to execute in a thread
    def trace(trace_name: nil, thread_args: [])
      @thread_count += 1
      trace_name ||= "thread_#{@thread_count}"

      tracer = Datadog::Tracing.send(:tracer)

      @threads << Thread.start(trace_name, tracer.provider.context, Array(thread_args)) do |name, context, args|
        tracer = Datadog::Tracing.send(:tracer)

        # c.f. https://github.com/DataDog/dd-trace-rb/issues/1460
        tracer.provider.context = context
        Datadog::Tracing.trace(name) do
          yield(*args)
        end
      end
    end

    def join_threads
      @threads.each(&:join)
    end
  end
end

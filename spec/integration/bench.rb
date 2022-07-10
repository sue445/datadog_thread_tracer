# frozen_string_literal: true

require_relative "../../lib/datadog_thread_tracer"

Datadog.configure do |c|
  c.agent.host = ENV.fetch("DD_AGENT_HOST", "127.0.0.1")

  c.service = "datadog_thread_tracer"
  c.env = "test"
  c.logger.level = ::Logger::WARN
end

start = Time.now

BENCH_SECONDS = 5

while Time.now < start + BENCH_SECONDS
  DatadogThreadTracer.trace do |t|
    t.trace do
      1 + 2
    end

    t.trace do
      2 * 3
    end
  end
  sleep 0.1
end

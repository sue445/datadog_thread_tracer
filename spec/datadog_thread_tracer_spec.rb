# frozen_string_literal: true

RSpec.describe DatadogThreadTracer do
  describe ".trace" do
    before do
      @request_body_spans = []
      stub_request(:post, "http://127.0.0.1:8126/v0.4/traces").
        to_return do |request|
          plain_request_body = MessagePack.unpack(request.body)
          @request_body_spans += plain_request_body.flatten
          @request_headers = request.headers
        end
    end

    it "trace in thread" do
      DatadogThreadTracer.trace do |tracer|
        tracer.trace do
          @result1 = 1
        end

        tracer.trace do
          @result2 = 2
        end
      end

      retry_count = 0
      while retry_count < 3
        break if @request_body_spans.count >= 3

        sleep 1
      end

      expect(@result1).to eq(1)
      expect(@result2).to eq(2)

      trace_ids = @request_body_spans.map { |span| span["trace_id"] }

      expect(trace_ids.count).to eq 3

      trace_id = trace_ids[0]
      expect(trace_ids).to all(eq(trace_id))
    end
  end
end
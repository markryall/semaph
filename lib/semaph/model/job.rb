module Semaph
  module Model
    class Job
      attr_reader(
        :pipeline,
        :id,
        :name,
        :status,
        :result,
        :block_name,
        :block_state,
        :block_result,
      )

      def initialize(pipeline, raw_block, raw_job)
        @pipeline = pipeline
        @raw_block = raw_block
        @raw_job = raw_job
        assign_from_job(raw_job)
        assign_from_block(raw_block)
      end

      def description
        [
          icon,
          @block_name,
          @block_state,
          @block_result,
          @name,
        ].join(" ")
      end

      def icon
        return "🔵" unless @status == "FINISHED"

        return "🟢" unless @result == "FAILED"

        "🔴"
      end

      private

      def assign_from_job(raw)
        @id = raw["job_id"]
        @status = raw["status"]
        @name = raw["name"]
        @result = raw["result"]
      end

      def assign_from_block(raw)
        @block_name = raw["name"]
        @block_state = raw["state"]
        @block_result = raw["result"]
      end
    end
  end
end


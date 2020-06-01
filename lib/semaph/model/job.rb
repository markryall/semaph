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
          block_icon,
          @block_name,
          job_icon,
          @name,
        ].join(" ")
      end

      # block_state can be done/running
      # block_result can be passed/failed
      def block_icon
        return "🔵" unless @block_state == "done"

        return "🟢" if @block_result == "passed"

        "🔴"
      end

      # status can be FINISHED/RUNNING
      # result can be PASSED/FAILED
      def job_icon
        return "🔵" unless @status == "FINISHED"

        return "🟢" if @result == "PASSED"

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

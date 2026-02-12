require "fileutils"

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

      def stop
        pipeline.workflow.project.client.stop_job(id)
      end

      def show
        pp pipeline.workflow.project.client.job(id)
      end

      def write_log(base)
        FileUtils.mkdir_p(base)
        filename = "#{base}/#{id}.log"
        return filename if File.exist?(filename)

        puts "retrieving log for job #{id}"
        content = pipeline.workflow.project.client.job_log(id)
        File.open("#{base}/#{id}.json", "w") do |file|
          file.puts hash.to_json
        end

        File.open(filename, "w") do |file|
          content["events"].each do |event|
            next unless event["output"]

            file.print event["output"]
          end
        end

        filename
      end

      def description
        [
          block_icon,
          @block_name,
          job_icon,
          @name,
        ].compact.join(" ")
      end

      def finished?
        @status == "FINISHED"
      end

      def failed?
        @result == "FAILED"
      end

      # block_state can be waiting/running/done
      # block_result can be passed/failed/canceled/stopped
      def block_icon
        return "🟠" if @block_state == "waiting"

        return "🔵" if @block_state == "running"

        return "⚪" if @block_result == "canceled"

        return "⛔" if @block_result == "stopped"

        return "🟢" if @block_result == "passed"

        "🔴"
      end

      # status can be FINISHED/RUNNING
      # result can be PASSED/FAILED/STOPPED
      def job_icon
        return nil unless @status

        return "🔵" unless @status == "FINISHED"

        return "⛔" if @result == "STOPPED"

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

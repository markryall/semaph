require "semaph/model/job"

module Semaph
  module Model
    class JobCollection
      attr_reader :all

      def initialize(pipeline)
        @pipeline = pipeline
      end

      def reload
        workflow = @pipeline.workflow
        project = workflow.project
        @all = build_jobs(project.client.pipeline(@pipeline.id))
      end

      def incomplete
        @all.reject { |job| job.block_state == "done" }
      end

      private

      def build_jobs(content)
        result = []
        blocks = content.delete("blocks")
        blocks.each do |block|
          jobs = block.delete("jobs").sort_by { |job| job["index"] }
          append_jobs(result, block, jobs)
        end
        result
      end

      def append_jobs(result, block, jobs)
        if jobs.count.positive?
          jobs.each { |job| result << Job.new(@pipeline, block, job) }
        else
          result << Job.new(@pipeline, block, {})
        end
      end
    end
  end
end

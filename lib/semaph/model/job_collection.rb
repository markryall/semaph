require "semaph/model/job"

module Semaph
  module Model
    class JobCollection
      attr_reader :all

      def initialize(pipeline)
        @pipeline = pipeline
        reload
      end

      def reload
        workflow = @pipeline.workflow
        project = workflow.project
        @all = build_jobs(project.client.pipeline(@pipeline.id))
      end

      private

      def build_jobs(content)
        result = []
        blocks = content.delete("blocks")
        blocks.each do |block|
          jobs = block.delete("jobs").sort_by { |job| job["index"] }
          jobs.each do |job|
            result << Job.new(@pipeline, block, job)
          end
        end
        result
      end
    end
  end
end

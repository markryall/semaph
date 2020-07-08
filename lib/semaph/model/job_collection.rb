require "date"
require "semaph/model/job"

module Semaph
  module Model
    class JobCollection
      attr_reader :all, :pipeline, :stopping_at, :running_at, :queuing_at, :pending_at, :done_at, :created_at

      def initialize(pipeline)
        @pipeline = pipeline
      end

      def reload
        workflow = @pipeline.workflow
        project = workflow.project
        @all = parse_content(project.client.pipeline(@pipeline.id))
      end

      def incomplete
        @all.reject(&:finished?)
      end

      def failed
        @all.select(&:failed?)
      end

      private

      def parse_content(content)
        parse_pipeline(content["pipeline"])
        result = []
        blocks = content.delete("blocks")
        blocks.each do |block|
          jobs = block.delete("jobs").sort_by { |job| job["index"] }
          append_jobs(result, block, jobs)
        end
        result
      end

      def parse_pipeline(pipeline_content)
        with_time(pipeline_content["stopping_at"]) { |time| @stopping_at = time }
        with_time(pipeline_content["running_at"]) { |time| @running_at = time }
        with_time(pipeline_content["queuing_at"]) { |time| @queuing_at = time }
        with_time(pipeline_content["pending_at"]) { |time| @pending_at = time }
        with_time(pipeline_content["done_at"]) { |time| @done_at = time }
        with_time(pipeline_content["created_at"]) { |time| @created_at = time }
      end

      def append_jobs(result, block, jobs)
        if jobs.count.positive?
          jobs.each { |job| result << Job.new(@pipeline, block, job) }
        else
          result << Job.new(@pipeline, block, {})
        end
      end

      def with_time(string)
        time = DateTime.parse(string).to_time
        yield time unless time.to_i.zero?
      end
    end
  end
end

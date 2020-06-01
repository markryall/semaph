require "semaph/model/pipeline_collection"

module Semaph
  module Model
    class Workflow
      attr_reader :project, :raw, :id, :sha, :branch, :branch_id, :created_at

      def initialize(project, raw)
        @project = project
        @raw = raw
        @id = raw["wf_id"]
        @sha = raw["commit_sha"]
        @created_at = Time.at(raw["created_at"]["seconds"].to_i)
        @branch = raw["branch_name"]
        @branch_id = raw["branch_id"]
        # @summary = `git log -n 1 --format="%h %an %ci %s" #{sha}`
      end

      def pipeline_collection
        @pipeline_collection ||= PipelineCollection.new(self)
      end
    end
  end
end

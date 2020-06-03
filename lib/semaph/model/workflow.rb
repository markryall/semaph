require "semaph/model/pipeline_collection"

module Semaph
  module Model
    class Workflow
      attr_reader :project, :raw, :id, :sha, :commit, :branch, :branch_id, :created_at

      def initialize(project, raw)
        @project = project
        @raw = raw
        @id = raw["wf_id"]
        @created_at = Time.at(raw["created_at"]["seconds"].to_i)
        @branch = raw["branch_name"]
        @branch_id = raw["branch_id"]
        extract_git_details
      end

      def extract_git_details
        @sha = raw["commit_sha"]
        @commit = @sha.slice(0..10)
        @commit = `git log -n 1 --format="%h %an %s" #{sha}`.chomp if `git cat-file -t #{sha} 2>&1`.chomp == "commit"
      end

      def pipeline_collection
        @pipeline_collection ||= PipelineCollection.new(self)
      end

      def rerun
        rerun_response = project.client.rerun_workflow(@id)
        workflow_response = project.client.workflow(rerun_response["wf_id"])
        Workflow.new(project, workflow_response["workflow"])
      end

      def stop
        project.client.stop_workflow(@id)
      end
    end
  end
end

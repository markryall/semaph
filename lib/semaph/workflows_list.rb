module Semaph
  class WorkflowsList
    attr_reader :usage, :help

    def initialize(api, project_id, parent_state)
      @api = api
      @project_id = project_id
      @parent_state = parent_state
      @usage = "<branch>"
      @help = "list available workflows"
    end

    def execute(branch)
      @parent_state[:workflows] = @api.workflows(@project_id, branch).map do |workflow|
        extract_workflow(workflow)
      end
      @parent_state[:workflows].each do |workflow|
        puts "#{workflow[:created_at]} #{workflow[:id]}"
      end
    end

    private

    def extract_workflow(workflow)
      {
        id: workflow["wf_id"],
        sha: workflow["commit_sha"],
        created_at: Time.at(workflow["created_at"]["seconds"].to_i),
        # summary: `git log -n 1 --format="%h %an %ci %s" #{sha}`,
      }
    end
  end
end

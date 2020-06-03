require "semaph/commands/reload_command"
require "semaph/commands/rerun_workflow_command"
require "semaph/commands/stop_workflow_command"
require "semaph/commands/visit_url_command"

module Semaph
  module Commands
    def self.workflow_commands(shell, workflow)
      shell.add_command ::Semaph::Commands::RerunWorkflowCommand.new(workflow), "rerun"
      shell.add_command ::Semaph::Commands::StopWorkflowCommand.new(workflow), "stop"
      add_open_workflow_command(shell, workflow)
      add_open_branch_command(shell, workflow)
      add_github_commands(shell, workflow)
    end

    def self.add_open_workflow_command(shell, workflow)
      shell.add_command(
        ::Semaph::Commands::VisitUrlCommand.new(
          "https://#{workflow.project.client.host}/workflows/#{workflow.id}",
          "browse to workflow",
        ),
        "open-workflow",
      )
    end

    def self.add_open_branch_command(shell, workflow)
      shell.add_command(
        ::Semaph::Commands::VisitUrlCommand.new(
          "https://#{workflow.project.client.host}/branches/#{workflow.branch_id}",
          "browse to branch in semaphore",
        ),
        "open-branch",
      )
    end

    def self.add_github_commands(shell, workflow)
      return unless workflow.project.github_url

      add_github_branch(shell, workflow)
      add_github_commit(shell, workflow)
    end

    def self.add_github_branch(shell, workflow)
      shell.add_command(
        ::Semaph::Commands::VisitUrlCommand.new(
          "#{workflow.project.github_url}/tree/#{workflow.branch}",
          "browse to the branch in github",
        ),
        "open-github-branch",
      )
    end

    def self.add_github_commit(shell, workflow)
      shell.add_command(
        ::Semaph::Commands::VisitUrlCommand.new(
          "#{workflow.project.github_url}/commit/#{workflow.sha}",
          "browse to the commit in github",
        ),
        "open-github-commit",
      )
    end
  end
end

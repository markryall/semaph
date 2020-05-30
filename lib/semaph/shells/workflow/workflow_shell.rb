require "semaph/commands/visit_url_command"
require "semaph/commands/reload_command"
require "semaph/shells/workflow/pipelines_list_command"
require "semaph/shells/workflow/pipelines_select_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Workflow
      class WorkflowShell
        include ShellShock::Context

        def initialize(workflow)
          @workflow = workflow
          project = @workflow.project
          @prompt = "🏗  #{project.client.host} #{project.name} #{workflow.id} > "
          pipeline_collection = workflow.pipeline_collection
          add_command PipelinesListCommand.new(pipeline_collection), "ls"
          add_command PipelinesSelectCommand.new(pipeline_collection), "cd"
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "https://#{project.client.host}/workflows/#{workflow.id}",
              "browse to workflow",
            ),
            "open-workflow",
          )
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "https://#{project.client.host}/branches/#{workflow.branch_id}",
              "browse to branch in semaphore",
            ),
            "open-branch",
          )
          add_github_commands(workflow)
          add_command(
            ::Semaph::Commands::ReloadCommand.new(pipeline_collection, "reload pipelines"),
            "reload",
          )
        end

        private

        def add_github_commands(workflow)
          return unless workflow.project.github_url

          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "#{workflow.project.github_url}/tree/#{workflow.branch}",
              "browse to the branch in github",
            ),
            "github-branch",
          )
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "#{workflow.project.github_url}/commit/#{workflow.sha}",
              "browse to the commit in github",
            ),
            "github-commit",
          )
        end
      end
    end
  end
end

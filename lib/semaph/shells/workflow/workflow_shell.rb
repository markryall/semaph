require "semaph/commands/visit_url_command"
require "semaph/shells/workflow/pipelines_list_command"
require "semaph/shells/workflow/pipelines_select_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Workflow
      class WorkflowShell
        attr_reader :workflow

        include ShellShock::Context

        def initialize(workflow)
          @workflow = workflow
          @prompt = "🏗  #{project.client.name} #{project.name} #{workflow.id} > "
          add_commands
          @list_command.execute("")
        end

        private

        def project
          @workflow.project
        end

        def pipeline_collection
          @workflow.pipeline_collection
        end

        def add_commands
          @list_command = PipelinesListCommand.new(pipeline_collection)
          add_command @list_command, "list-pipelines"
          add_command PipelinesSelectCommand.new(pipeline_collection), "select-pipeline"
          add_open_branch_command
          add_github_commands
        end

        def add_open_workflow_command
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "https://#{project.client.host}/workflows/#{workflow.id}",
              "browse to workflow",
            ),
            "open-workflow",
          )
        end

        def add_open_branch_command
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "https://#{project.client.host}/branches/#{workflow.branch_id}",
              "browse to branch in semaphore",
            ),
            "open-branch",
          )
        end

        def add_github_commands
          return unless workflow.project.github_url

          add_github_branch
          add_github_commit
        end

        def add_github_branch
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "#{workflow.project.github_url}/tree/#{workflow.branch}",
              "browse to the branch in github",
            ),
            "open-github-branch",
          )
        end

        def add_github_commit
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "#{workflow.project.github_url}/commit/#{workflow.sha}",
              "browse to the commit in github",
            ),
            "open-github-commit",
          )
        end
      end
    end
  end
end

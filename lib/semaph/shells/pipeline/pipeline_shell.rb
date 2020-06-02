require "semaph/commands/reload_command"
require "semaph/commands/rerun_workflow_command"
require "semaph/shells/pipeline/jobs_list_command"
require "semaph/shells/pipeline/jobs_logs_command"
require "semaph/shells/pipeline/jobs_poll_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Pipeline
      class PipelineShell
        attr_reader :pipeline

        include ShellShock::Context

        def initialize(pipeline)
          @pipeline = pipeline
          @prompt = "🏗  #{project.client.name} #{project.name} #{workflow.id} #{pipeline.yaml} > "
          add_commands
          @jobs_list_command.execute("")
        end

        private

        def project
          workflow.project
        end

        def workflow
          pipeline.workflow
        end

        def job_collection
          pipeline.job_collection
        end

        def add_commands
          @jobs_list_command = JobsListCommand.new(job_collection)
          add_command @jobs_list_command, "list-jobs"
          add_command JobsPollCommand.new(job_collection), "poll-jobs"
          add_command JobsLogsCommand.new(job_collection), "jobs-logs"
          add_command ::Semaph::Commands::RerunWorkflowCommand.new(workflow), "rerun"
          add_open_branch_command
          add_open_workflow_command
          add_github_commands
          add_command ::Semaph::Commands::ReloadCommand.new, "reload" if ENV["SEMAPH_RELOAD"]
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

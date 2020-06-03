require "semaph/commands"
require "semaph/shells/pipeline/jobs_list_command"
require "semaph/shells/pipeline/job_log_command"
require "semaph/shells/pipeline/job_log_grep_command"
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
          workflow = pipeline.workflow
          project = workflow.project
          @prompt = "🏗  #{project.client.name} #{project.name} #{workflow.id} #{pipeline.yaml} > "
          add_commands
          @jobs_list_command.execute("")
        end

        private

        def add_commands
          add_command ::Semaph::Commands::ReloadCommand.new, "reload" if ENV["SEMAPH_RELOAD"]
          workflow = pipeline.workflow
          ::Semaph::Commands.workflow_commands(self, workflow)
          add_job_collection_commands(pipeline.job_collection)
        end

        def add_job_collection_commands(job_collection)
          @jobs_list_command = JobsListCommand.new(job_collection)
          add_command @jobs_list_command, "list-jobs", "ls"
          add_command JobsPollCommand.new(job_collection), "poll-jobs"
          add_command JobLogCommand.new(job_collection), "job-log"
          add_command JobLogGrepCommand.new(job_collection, :all), "grep-all-logs"
          add_command JobLogGrepCommand.new(job_collection, :failed), "grep-failed-logs"
        end
      end
    end
  end
end

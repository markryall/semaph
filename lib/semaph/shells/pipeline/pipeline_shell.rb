require "semaph/commands"
require "semaph/shells/pipeline/job_debug_command"
require "semaph/shells/pipeline/job_log_command"
require "semaph/shells/pipeline/job_log_grep_command"
require "semaph/shells/pipeline/job_show_command"
require "semaph/shells/pipeline/job_stop_command"
require "semaph/shells/pipeline/jobs_list_command"
require "semaph/shells/pipeline/jobs_poll_command"
require "semaph/shells/pipeline/promote_command"
require "semaph/shells/pipeline/promotions_list_command"
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
          @jobs_list_command.execute
        end

        private

        def add_commands
          add_command ::Semaph::Commands::ReloadCommand.new, "reload" if ENV["SEMAPH_RELOAD"]
          workflow = pipeline.workflow
          ::Semaph::Commands.workflow_commands(self, workflow)
          add_job_collection_commands(pipeline.job_collection)
          add_command PromoteCommand.new(pipeline), "promote"
          add_command PromotionsListCommand.new(pipeline.promotion_collection), "list-promotions"
        end

        def add_job_collection_commands(job_collection)
          @jobs_list_command = JobsListCommand.new(job_collection)
          add_command @jobs_list_command, "list-jobs", "ls"
          add_command JobsPollCommand.new(job_collection, @jobs_list_command), "poll"
          add_command JobLogCommand.new(job_collection), "log"
          add_command JobDebugCommand.new(job_collection), "debug"
          add_command JobShowCommand.new(job_collection), "show"
          add_command JobStopCommand.new(job_collection), "stop"
          add_command JobLogGrepCommand.new(job_collection, :all), "grep-all-logs"
          add_command JobLogGrepCommand.new(job_collection, :failed), "grep-failed-logs"
        end
      end
    end
  end
end

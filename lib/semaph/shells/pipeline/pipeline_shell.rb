require "semaph/shells/pipeline/jobs_list_command"
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
          @prompt = "🏗  #{project.client.host} #{project.name} #{workflow.id} #{pipeline.yaml} > "
          add_commands
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
          add_command(
            ::Semaph::Commands::ReloadCommand.new(job_collection, "reload jobs"),
            "reload-jobs",
          )
          add_command JobsListCommand.new(job_collection), "list-jobs"
          add_command JobsPollCommand.new(job_collection), "poll-jobs"
        end
      end
    end
  end
end

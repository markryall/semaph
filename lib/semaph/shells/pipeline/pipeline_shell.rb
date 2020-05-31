require "semaph/shells/pipeline/jobs_list_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Pipeline
      class PipelineShell
        include ShellShock::Context

        def initialize(pipeline)
          @pipeline = pipeline
          workflow = pipeline.workflow
          project = workflow.project
          @prompt = "🏗  #{project.client.host} #{project.name} #{workflow.id} #{pipeline.yaml} > "
          job_collection = pipeline.job_collection
          add_command(
            ::Semaph::Commands::ReloadCommand.new(job_collection, "reload jobs"),
            "reload-jobs",
          )
          add_command JobsListCommand.new(job_collection), "list-jobs"
        end
      end
    end
  end
end
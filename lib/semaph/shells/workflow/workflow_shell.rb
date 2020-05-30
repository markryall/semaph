require "semaph/commands/reload_command"
require "semaph/shells/workflow/pipelines_list_command"
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
          add_command(
            ::Semaph::Commands::ReloadCommand.new(pipeline_collection, "reload pipelines"),
            "reload",
          )
        end
      end
    end
  end
end

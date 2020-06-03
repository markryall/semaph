require "semaph/commands"
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
          project = @workflow.project
          @prompt = "🏗  #{project.client.name} #{project.name} #{workflow.id} > "
          add_commands
          @list_command.execute("")
        end

        private

        def add_commands
          pipeline_collection = @workflow.pipeline_collection
          @list_command = PipelinesListCommand.new(pipeline_collection)
          add_command @list_command, "list-pipelines", "ls"
          add_command PipelinesSelectCommand.new(pipeline_collection), "select-pipeline", "cd"
          add_command ::Semaph::Commands::ReloadCommand.new, "reload" if ENV["SEMAPH_RELOAD"]
          ::Semaph::Commands.workflow_commands(self, workflow)
        end
      end
    end
  end
end

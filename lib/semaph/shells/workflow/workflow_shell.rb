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
        end
      end
    end
  end
end

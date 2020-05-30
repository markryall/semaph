require "semaph/shells/project/workflows_list_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Project
      class ProjectShell
        include ShellShock::Context

        def initialize(project)
          @prompt = "🏗  #{project.client.host} #{project.name} > "
          workflow_collection = project.workflow_collection
          add_command WorkflowsListCommand.new(workflow_collection), "ls"
        end
      end
    end
  end
end

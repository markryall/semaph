require "shell_shock/context"
require "semaph/workflows_list"

module Semaph
  class ProjectContext
    include ShellShock::Context

    def initialize(project)
      @prompt = "🏗  #{project.client.host} #{project.name} > "
      workflow_collection = project.workflow_collection
      add_command WorkflowsList.new(workflow_collection), "ls"
    end
  end
end

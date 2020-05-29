require "shell_shock/context"
require "semaph/workflows_list"

module Semaph
  class ProjectContext
    include ShellShock::Context

    def initialize(api, project)
      @prompt = "#{project[:name]} > "
      @state = { workflows: [] }
      add_command WorkflowsList.new(api, project[:id], @state), "ls"
    end
  end
end

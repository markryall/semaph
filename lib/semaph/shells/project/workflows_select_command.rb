require "semaph/shells/workflow/workflow_shell"

module Semaph
  module Shells
    module Project
      class WorkflowsSelectCommand
        attr_reader :usage, :help

        def initialize(workflow_collection)
          @workflow_collection = workflow_collection
          @usage = "<workflow index>"
          @help = "choose workflow by index"
        end

        def execute(index_string)
          index = index_string.to_i - 1
          ::Semaph::Shells::Workflow::WorkflowShell.new(
            @workflow_collection.all[index],
          ).push
        end
      end
    end
  end
end

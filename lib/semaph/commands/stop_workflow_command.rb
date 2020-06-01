require "semaph/shells/workflow/workflow_shell"

module Semaph
  module Commands
    class StopWorkflowCommand
      attr_reader :help

      def initialize(workflow)
        @workflow = workflow
        @help = "stop workflow"
      end

      def execute(_whatever)
        @workflow.stop
      end
    end
  end
end

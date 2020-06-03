module Semaph
  module Commands
    class RerunWorkflowCommand
      attr_reader :help

      def initialize(workflow)
        @workflow = workflow
        @help = "rerun workflow"
      end

      def execute(_whatever)
        ::Semaph::Shells::Workflow::WorkflowShell.new(@workflow.rerun).push
      end
    end
  end
end

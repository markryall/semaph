require "semaph/formatting"

module Semaph
  module Shells
    module Project
      class WorkflowsListCommand
        attr_reader :usage, :help

        def initialize(workflow_collection)
          @workflow_collection = workflow_collection
          @usage = "<branch>"
          @help = "list available workflows"
        end

        def execute(branch)
          @workflow_collection.reload
          @workflow_collection.all.slice(0..5).each_with_index do |workflow, index|
            next unless workflow.branch.include?(branch)

            workflow.pipeline_collection.reload

            puts [
              ::Semaph::Formatting.index(index + 1),
              workflow.pipeline_collection.all.last&.icon,
              workflow.pipeline_collection.all.count,
              workflow.description,
            ].join(" ")
          end
        end
      end
    end
  end
end

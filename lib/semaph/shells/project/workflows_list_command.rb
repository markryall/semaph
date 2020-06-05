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
          @workflow_collection.all.each_with_index do |workflow, index|
            next unless workflow.branch.include?(branch)

            puts "#{index + 1} #{workflow.description}"
          end
        end
      end
    end
  end
end

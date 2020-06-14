require 'rainbow'

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

            puts [display_index(index + 1), workflow.description].join(" ")
          end
        end

        def display_index(index)
          Rainbow(index.to_s.rjust(2)).yellow
        end
      end
    end
  end
end

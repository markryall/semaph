module Semaph
  module Shells
    module Project
      class WorkflowsListCommand
        TIME_FORMAT = "%Y-%m-%d %H:%M:%S".freeze

        attr_reader :usage, :help

        def initialize(workflow_collection)
          @workflow_collection = workflow_collection
          @usage = "<branch>"
          @help = "list available workflows"
        end

        def execute(branch)
          @workflow_collection.all.each_with_index do |workflow, index|
            next unless workflow.branch.include?(branch)

            puts description(index, workflow)
          end
        end

        private

        def description(index, workflow)
          [
            index + 1,
            workflow.created_at.strftime(TIME_FORMAT),
            "SHA",
            workflow.sha,
            "on branch",
            workflow.branch,
          ].join(" ")
        end
      end
    end
  end
end

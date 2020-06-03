module Semaph
  module Shells
    module Project
      class WorkflowsListCommand
        TIME_FORMAT = "%m-%d %H:%M".freeze

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

            puts description(index, workflow)
          end
        end

        private

        def description(index, workflow)
          [
            index + 1,
            workflow.created_at.strftime(TIME_FORMAT),
            "on branch",
            "#{workflow.branch}:",
            workflow.commit,
          ].join(" ")
        end
      end
    end
  end
end

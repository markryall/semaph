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
          @workflow_collection.reload(branch)
          @workflow_collection.all.slice(0..9).each_with_index do |workflow, index|
            next unless workflow.branch.include?(branch)

            pipelines = workflow.pipeline_collection.reload

            puts content(index, pipelines, workflow)
          end
        end

        private

        def content(index, pipelines, workflow)
          [
            ::Semaph::Formatting.index(index + 1),
            pipelines.last&.icon,
            ::Semaph::Formatting.length(pipelines),
            workflow.description,
          ].join(" ")
        end
      end
    end
  end
end

require "semaph/model/pipeline"

module Semaph
  module Model
    class PipelineCollection
      attr_reader :all

      def initialize(workflow)
        @workflow = workflow
        reload
      end

      def reload
        project = @workflow.project
        @all = project.client.pipelines({ wf_id: @workflow.id }).map do |content|
          Pipeline.new @workflow, content
        end
      end
    end
  end
end

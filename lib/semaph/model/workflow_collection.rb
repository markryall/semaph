require "semaph/model/workflow"

module Semaph
  module Model
    class WorkflowCollection
      attr_reader :all

      def initialize(project)
        @project = project
      end

      def reload(branch)
        @all = @project.client.workflows(@project.id, branch).map do |content|
          Workflow.new @project, content
        end
      end
    end
  end
end

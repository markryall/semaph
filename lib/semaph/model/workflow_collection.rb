require "semaph/model/workflow"

module Semaph
  module Model
    class WorkflowCollection
      attr_reader :all

      def initialize(client, project)
        @client = client
        @project = project
        reload
      end

      def reload
        @all = @client.workflows(@project.id).map do |content|
          Workflow.new @client, content
        end
      end
    end
  end
end

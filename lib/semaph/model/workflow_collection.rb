require "semaph/model/workflow"

module Semaph
  module Model
    class WorkflowCollection
      include Enumerable

      def initialize(client, project)
        @client = client
        @project = project
        reload
      end

      def each
        @workflows.each { |project| yield project }
      end

      def reload
        @workflows = @client.workflows(@project.id).map do |content|
          Workflow.new @client, content
        end
      end
    end
  end
end

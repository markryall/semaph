module Semaph
  class WorkflowsList
    attr_reader :usage, :help

    def initialize(workflow_collection)
      @workflow_collection = workflow_collection
      @usage = "<branch>"
      @help = "list available workflows"
    end

    def execute(branch)
      @workflow_collection.each do |workflow|
        puts "#{workflow.created_at} SHA #{workflow.sha}" if workflow.branch == branch
      end
    end
  end
end

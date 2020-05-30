require "semaph/project_context"

module Semaph
  class ProjectsSelect
    attr_reader :usage, :help

    def initialize(project_collection)
      @project_collection = project_collection
      @usage = "<project>"
      @help = "choose project"
    end

    def completion(text)
      @project_collection.map(&:name).grep(/^#{text}/).sort
    end

    def execute(name)
      selected_project = @project_collection.find { |project| project.name == name }
      ProjectContext.new(selected_project).push
    end
  end
end

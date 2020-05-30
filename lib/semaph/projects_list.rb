module Semaph
  class ProjectsList
    attr_reader :usage, :help

    def initialize(project_collection)
      @project_collection = project_collection
      @help = "list available projects"
    end

    def execute(_whatever)
      @project_collection.each do |project|
        puts project.name
      end
    end
  end
end

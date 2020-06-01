module Semaph
  module Shells
    module Organisation
      class ProjectsListCommand
        attr_reader :usage, :help

        def initialize(project_collection)
          @project_collection = project_collection
          @help = "list available projects"
        end

        def execute(_whatever)
          @project_collection.reload
          @project_collection.all.each do |project|
            puts project.name
          end
        end
      end
    end
  end
end

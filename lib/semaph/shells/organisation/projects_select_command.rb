require "semaph/shells/project/project_shell"

module Semaph
  module Shells
    module Organisation
      class ProjectsSelectCommand
        attr_reader :usage, :help

        def initialize(project_collection)
          @project_collection = project_collection
          @usage = "<project>"
          @help = "choose project"
        end

        def completion(text)
          @project_collection.all.map(&:name).grep(/^#{text}/).sort
        end

        def execute(name)
          selected_project = @project_collection.all.find { |project| project.name == name }
          ::Semaph::Shells::Project::ProjectShell.new(selected_project).push
        end
      end
    end
  end
end

require "yaml"

module Semaph
  module Shells
    module Project
      class SaveCommand
        attr_reader :help, :project

        def initialize(project)
          @project = project
          @help = "save current project as default for this folder"
        end

        def execute(_ignored)
          config = {
            host: project.client.host,
            project: project.raw,
          }
          File.open(".semaph", "w") do |file|
            file.puts config.to_yaml
          end
        end
      end
    end
  end
end

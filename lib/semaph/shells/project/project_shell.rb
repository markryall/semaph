require "semaph/commands/visit_url_command"
require "semaph/commands/reload_command"
require "semaph/shells/project/workflows_list_command"
require "semaph/shells/project/workflows_select_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Project
      class ProjectShell
        attr_reader :project

        include ShellShock::Context

        def initialize(project)
          @project = project
          @prompt = "🏗  #{project.client.host} #{project.name} > "
          add_commands
        end

        private

        def workflow_collection
          project.workflow_collection
        end

        def add_commands
          add_github_command
          add_open_project_command
          add_command(
            ::Semaph::Commands::ReloadCommand.new(workflow_collection, "reload workflows"),
            "reload-workflows",
          )
          add_command WorkflowsListCommand.new(workflow_collection), "list-workflows"
          add_command WorkflowsSelectCommand.new(workflow_collection), "select-workflow"
        end

        def add_github_command
          return unless project.github_url

          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              project.github_url,
              "browse to github project",
            ),
            "open-github",
          )
        end

        def add_open_project_command
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "https://#{project.client.host}/projects/#{project.name}",
              "browse to project",
            ),
            "open-project",
          )
        end
      end
    end
  end
end

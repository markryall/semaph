require "semaph/commands/reload_command"
require "semaph/commands/visit_url_command"
require "semaph/shells/project/save_command"
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
          @prompt = "🏗  #{project.client.name} #{project.name} > "
          add_commands
        end

        private

        def workflow_collection
          project.workflow_collection
        end

        def add_commands
          add_github_command
          add_open_project_command
          add_command SaveCommand.new(project), "save"
          @workflows_list_command = WorkflowsListCommand.new(workflow_collection)
          add_command @workflows_list_command, "list-workflows", "ls"
          add_command WorkflowsSelectCommand.new(workflow_collection), "select-workflow", "cd"
          add_command ::Semaph::Commands::ReloadCommand.new, "reload" if ENV["SEMAPH_RELOAD"]
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

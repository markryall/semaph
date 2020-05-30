require "semaph/commands/visit_url_command"
require "semaph/commands/reload_command"
require "semaph/shells/project/workflows_list_command"
require "semaph/shells/project/workflows_select_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Project
      class ProjectShell
        include ShellShock::Context

        def initialize(project)
          @prompt = "🏗  #{project.client.host} #{project.name} > "
          workflow_collection = project.workflow_collection
          add_github_command(project)
          add_command(
            ::Semaph::Commands::ReloadCommand.new(workflow_collection, "reload workflows"),
            "reload",
          )
          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              "https://#{project.client.host}/projects/#{project.name}",
              "browse to project",
            ),
            "open",
          )
          add_command WorkflowsListCommand.new(workflow_collection), "ls"
          add_command WorkflowsSelectCommand.new(workflow_collection), "cd"
        end

        private

        def add_github_command(project)
          return unless project.github_url

          add_command(
            ::Semaph::Commands::VisitUrlCommand.new(
              project.github_url,
              "browse to github project",
            ),
            "github",
          )
        end
      end
    end
  end
end

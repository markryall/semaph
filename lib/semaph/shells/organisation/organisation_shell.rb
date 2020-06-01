require "semaph/api"
require "semaph/commands/reload_command"
require "semaph/model/project_collection"
require "semaph/shells/organisation/projects_list_command"
require "semaph/shells/organisation/projects_select_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Organisation
      class OrganisationShell
        include ShellShock::Context

        def initialize(organisation)
          client = ::Semaph::Api.new(organisation["auth"]["token"], organisation["host"])
          @prompt = "🏗  #{client.name} > "
          project_collection = ::Semaph::Model::ProjectCollection.new(client)
          add_command ProjectsListCommand.new(project_collection), "list-projects"
          add_command ProjectsSelectCommand.new(project_collection), "select-project"
          add_command(
            ::Semaph::Commands::ReloadCommand.new(project_collection, "reload projects"),
            "reload-projects",
          )
        end
      end
    end
  end
end

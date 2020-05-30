require "semaph/api"
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
          host = organisation["host"]
          @prompt = "🏗  #{host} > "
          client = ::Semaph::Api.new(organisation["auth"]["token"], host)
          project_collection = ::Semaph::Model::ProjectCollection.new(client)
          add_command ProjectsListCommand.new(project_collection), "ls"
          add_command ProjectsSelectCommand.new(project_collection), "cd"
        end
      end
    end
  end
end

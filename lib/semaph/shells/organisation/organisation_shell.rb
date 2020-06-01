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
          @client = ::Semaph::Api.new(organisation["auth"]["token"], organisation["host"])
          @prompt = "🏗  #{@client.name} > "
          add_commands
          @project_list_command.execute("")
        end

        private

        def add_commands
          project_collection = ::Semaph::Model::ProjectCollection.new(@client)
          @project_list_command = ProjectsListCommand.new(project_collection)
          add_command @project_list_command, "list-projects"
          add_command ProjectsSelectCommand.new(project_collection), "select-project"
        end
      end
    end
  end
end

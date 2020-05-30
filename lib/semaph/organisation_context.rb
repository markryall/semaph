require "shell_shock/context"
require "semaph/projects_list"
require "semaph/projects_select"
require "semaph/api"
require "semaph/model/project_collection"

module Semaph
  class OrganisationContext
    include ShellShock::Context

    def initialize(organisation)
      host = organisation["host"]
      @prompt = "🏗  #{host} > "
      client = Api.new(organisation["auth"]["token"], host)
      project_collection = Model::ProjectCollection.new(client)
      add_command ProjectsList.new(project_collection), "ls"
      add_command ProjectsSelect.new(project_collection), "cd"
    end
  end
end

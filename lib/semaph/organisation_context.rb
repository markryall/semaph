require "shell_shock/context"
require "semaph/projects_list"
require "semaph/projects_select"
require "semaph/api"

module Semaph
  class OrganisationContext
    include ShellShock::Context

    def initialize(organisation)
      host = organisation["host"]
      @prompt = "#{host} > "
      @state = { projects: [] }
      api = Api.new(organisation["auth"]["token"], host)
      add_command ProjectsList.new(api, @state), "ls"
      add_command ProjectsSelect.new(api, @state), "cd"
    end
  end
end

require "shell_shock/context"
require "semaph/projects_list"
require "semaph/api"

module Semaph
  class OrganisationContext
    include ShellShock::Context

    def initialize(organisation)
      @host = organisation["host"]
      @token = organisation["auth"]["token"]
      @prompt = "#{@host} > "
      api = Api.new(@token, @host)
      add_command ProjectsList.new(api), "ls"
    end
  end
end

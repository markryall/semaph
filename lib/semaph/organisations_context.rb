require "shell_shock/context"
require "semaph/organisations_list"
require "semaph/organisations_select"

module Semaph
  class OrganisationsContext
    include ShellShock::Context

    def initialize(credentials)
      @credentials = credentials
      @prompt = "semaph > "
      add_command OrganisationsList.new(credentials), "ls"
      add_command OrganisationsSelect.new(credentials), "cd"
    end
  end
end

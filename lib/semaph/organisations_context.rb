require "shell_shock/context"
require "semaph/organisations_list"
require "semaph/organisations_select"

module Semaph
  class OrganisationsContext
    include ShellShock::Context

    def initialize(organisations)
      @organisations = organisations
      @prompt = "semaph > "
      add_command OrganisationsList.new(organisations), "ls"
      add_command OrganisationsSelect.new(organisations), "cd"
    end
  end
end

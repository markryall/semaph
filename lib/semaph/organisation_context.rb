require "shell_shock/context"
require "semaph/organisations_list"
require "semaph/organisations_select"

module Semaph
  class OrganisationContext
    include ShellShock::Context

    def initialize(organisation)
      @host = organisation["host"]
      @token = organisation["auth"]["token"]
      @prompt = "#{@host} > "
    end
  end
end

require "semaph/shells/organisations/organisations_list_command"
require "semaph/shells/organisations/organisations_select_command"
require "shell_shock/context"

module Semaph
  module Shells
    module Organisations
      class OrganisationsShell
        include ShellShock::Context

        def initialize(organisations)
          @organisations = organisations
          @prompt = "🏗  > "
          add_command OrganisationsListCommand.new(organisations), "list-organisations"
          add_command OrganisationsSelectCommand.new(organisations), "select-organisation"
        end
      end
    end
  end
end

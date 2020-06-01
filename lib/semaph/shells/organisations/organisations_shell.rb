require "semaph/commands/reload_command"
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
          organisations_list_command = OrganisationsListCommand.new(organisations)
          add_command organisations_list_command, "list-organisations"
          add_command OrganisationsSelectCommand.new(organisations), "select-organisation"
          add_command ::Semaph::Commands::ReloadCommand.new, "reload" if ENV["SEMAPH_RELOAD"]
          organisations_list_command.execute("")
        end
      end
    end
  end
end

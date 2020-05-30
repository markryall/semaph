require "semaph/shells/organisation/organisation_shell"

module Semaph
  module Shells
    module Organisations
      class OrganisationsSelectCommand
        attr_reader :usage, :help

        def initialize(organisations)
          @organisations = organisations
          @usage = "<organisation>"
          @help = "choose organisation"
        end

        def completion(text)
          @organisations.keys.grep(/^#{text}/).sort
        end

        def execute(name)
          ::Semaph::Shells::Organisation::OrganisationShell.new(@organisations[name]).push
        end
      end
    end
  end
end

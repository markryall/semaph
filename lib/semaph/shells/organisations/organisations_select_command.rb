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
          @organisations.map { |org| org["host"].split(".").first }.grep(/^#{text}/).sort
        end

        def execute(name)
          organisation = @organisations.find do |org|
            org["host"].split(".").first == name
          end

          unless organisation
            puts "There is no organisation called #{name}"
            return
          end

          ::Semaph::Shells::Organisation::OrganisationShell.new(organisation).push
        end
      end
    end
  end
end

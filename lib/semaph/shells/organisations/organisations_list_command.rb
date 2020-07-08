module Semaph
  module Shells
    module Organisations
      class OrganisationsListCommand
        attr_reader :usage, :help

        def initialize(organisations)
          @organisations = organisations
          @help = "list available organisations"
        end

        def execute(_whatever)
          @organisations.each do |organisation|
            puts organisation["host"].split(".").first
          end
        end
      end
    end
  end
end

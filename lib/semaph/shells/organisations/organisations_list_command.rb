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
          @organisations.each_key do |name|
            puts "#{name} (#{@organisations[name]['host']})"
          end
        end
      end
    end
  end
end

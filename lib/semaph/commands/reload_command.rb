module Semaph
  module Commands
    class ReloadCommand
      attr_reader :help

      def initialize
        @help = "reload all code"
      end

      def execute(_whatever)
        Dir["lib/**/*.rb"].each do |path|
          load path
        end
      end
    end
  end
end

module Semaph
  module Commands
    class VisitUrlCommand
      attr_reader :help

      def initialize(url, help)
        @url = url
        @help = help
      end

      def execute(_whatever)
        system("open #{@url}")
      end
    end
  end
end

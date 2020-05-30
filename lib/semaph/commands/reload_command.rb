module Semaph
  module Commands
    class ReloadCommand
      attr_reader :help

      def initialize(entity, help)
        @entity = entity
        @help = help
      end

      def execute(_whatever)
        @entity.reload
      end
    end
  end
end

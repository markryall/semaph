module Semaph
  module Shells
    module Pipeline
      class PromoteCommand
        attr_reader :usage, :help

        def initialize(pipeline)
          @pipeline = pipeline
          @usage = "<promotion name>"
          @help = "promote pipeline"
        end

        def execute(name)
          @pipeline.promote(name.chomp.strip)
        end
      end
    end
  end
end

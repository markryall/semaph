require "semaph/formatting"

module Semaph
  module Shells
    module Workflow
      class PipelinesListCommand
        attr_reader :usage, :help

        def initialize(pipeline_collection)
          @pipeline_collection = pipeline_collection
          @help = "list pipelines"
        end

        def execute(_whatever)
          @pipeline_collection.reload
          @pipeline_collection.all.each_with_index do |pipeline, index|
            puts [::Semaph::Formatting.index(index + 1), pipeline.description].join(" ")
          end
        end
      end
    end
  end
end

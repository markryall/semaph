require 'rainbow'

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
            puts [display_index(index + 1), pipeline.description].join(' ')
          end
        end

        def display_index(index)
          Rainbow(index.to_s.rjust(2)).yellow
        end
      end
    end
  end
end

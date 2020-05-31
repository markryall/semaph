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
          @pipeline_collection.all.each_with_index do |pipeline, index|
            puts "#{index + 1} #{icon(pipeline)} #{pipeline.yaml}"
          end
        end

        def icon(pipeline)
          return "🔵" unless pipeline.state == "DONE"

          return "🟢" unless pipeline.result == "FAILED"

          "🔴"
        end
      end
    end
  end
end

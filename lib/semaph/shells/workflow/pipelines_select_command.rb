require "semaph/shells/pipeline/pipeline_shell"

module Semaph
  module Shells
    module Workflow
      class PipelinesSelectCommand
        attr_reader :usage, :help

        def initialize(pipeline_collection)
          @pipeline_collection = pipeline_collection
          @usage = "<pipeline index>"
          @help = "choose pipeline by index"
        end

        def execute(index_string)
          index = index_string.to_i - 1

          pipeline = @pipeline_collection.all[index]

          unless pipeline
            puts "There is no pipeline at position #{index}"
            return
          end

          ::Semaph::Shells::Pipeline::PipelineShell.new(pipeline).push
        end
      end
    end
  end
end

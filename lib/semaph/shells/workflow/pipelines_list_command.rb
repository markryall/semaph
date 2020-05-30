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
          @pipeline_collection.all.each do |pipeline|
            puts "#{pipeline.yaml} #{pipeline.state} #{pipeline.result}"
          end
        end
      end
    end
  end
end

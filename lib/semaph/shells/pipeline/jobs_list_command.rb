module Semaph
  module Shells
    module Pipeline
      class JobsListCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @help = "list jobs"
        end

        def execute(_whatever)
          @job_collection.all.each { |job| puts job.description }
        end
      end
    end
  end
end

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
          @job_collection.all.each do |job|
            puts description(job)
          end
        end

        private

        def description(job)
          [
            job.block_name,
            job.block_state,
            job.block_result,
            job.name,
            job.status,
            job.result,
          ].join(" ")
        end
      end
    end
  end
end

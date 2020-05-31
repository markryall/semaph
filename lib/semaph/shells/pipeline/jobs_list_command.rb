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
            icon(job),
            job.block_name,
            job.block_state,
            job.block_result,
            job.name,
          ].join(" ")
        end

        def icon(job)
          return "🔵" unless job.status == "FINISHED"

          return "🟢" unless job.status == "FAILED"

          "🔴"
        end
      end
    end
  end
end

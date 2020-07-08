require "fileutils"

module Semaph
  module Shells
    module Pipeline
      class JobLogCommand
        attr_reader :usage, :help, :job_collection

        def initialize(job_collection)
          @job_collection = job_collection
          @usage = "<job index>"
          @help = "retrieve log for job"
        end

        def execute(index_string)
          with_job(index_string) { |job| system(command(job)) }
        end

        private

        def command(job)
          base = "tmp/logs/pipeline/#{job_collection.pipeline.id}"

          return "less #{job.write_log(base)}" if job.finished?

          "open https://#{job_collection.pipeline.workflow.project.client.host}/jobs/#{job.id}"
        end

        def with_job(index_string)
          index = index_string.to_i - 1

          job = job_collection.all[index]

          unless job
            puts "There is no job at position #{index}"
            return
          end

          yield job
        end
      end
    end
  end
end

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
          base = "tmp/logs/pipeline/#{job_collection.pipeline.id}"

          with_job(index_string) do |job|
            if job.finished?
              system("less #{job.write_log(base)}")
            else
              system("open https://#{job_collection.pipeline.workflow.project.client.host}/jobs/#{job.id}")
            end
          end
        end

        private

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

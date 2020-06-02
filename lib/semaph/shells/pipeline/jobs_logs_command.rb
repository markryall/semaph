module Semaph
  module Shells
    module Pipeline
      class JobsLogsCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @help = "retrieve logs for failed jobs"
        end

        def execute(_whatever)
          @job_collection.failed.each do |job|
            File.open("#{job.id}.log", "w") do |file|
              file.puts job.log
            end
          end
        end
      end
    end
  end
end

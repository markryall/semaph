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
            filename = "#{job.id}.log"
            File.open(filename, "w") { |file| file.puts job.log } unless File.exist?(filename)
            system("less #{filename}")
          end
        end
      end
    end
  end
end

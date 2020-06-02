module Semaph
  module Shells
    module Pipeline
      class JobsLogsCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @usage = "<job index>"
          @help = "retrieve log for job"
        end

        def execute(index_string)
          index = index_string.to_i - 1

          job = @job_collection.all[index]

          unless job
            puts "There is no job at position #{index}"
            return
          end

          filename = "#{job.id}.log"
          File.open(filename, "w") { |file| file.puts job.log } unless File.exist?(filename)
          system("less #{filename}")
        end
      end
    end
  end
end

module Semaph
  module Shells
    module Pipeline
      class JobStopCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @usage = "<job index>"
          @help = "stop job"
        end

        def execute(index_string)
          index = index_string.to_i - 1

          job = @job_collection.all[index]

          unless job
            puts "There is no job at position #{index}"
            return
          end

          job.stop
        end
      end
    end
  end
end

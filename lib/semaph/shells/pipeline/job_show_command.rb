module Semaph
  module Shells
    module Pipeline
      class JobShowCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @usage = "<job index>"
          @help = "show job"
        end

        def execute(index_string)
          index = index_string.to_i - 1

          job = @job_collection.all[index]

          unless job
            puts "There is no job at position #{index}"
            return
          end

          puts job.show
        end
      end
    end
  end
end

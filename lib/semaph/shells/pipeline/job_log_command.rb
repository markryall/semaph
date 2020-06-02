require "fileutils"

module Semaph
  module Shells
    module Pipeline
      class JobLogCommand
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

          unless job.finished?
            puts "This job has not finished yet"
            return
          end

          base = "tmp/logs/pipeline/#{job.pipeline.id}"
          FileUtils.mkdir_p(base)
          filename = "#{base}/#{job.id}.log"
          unless File.exist?(filename)
            puts "retrieving log for job #{job.id}"
            File.open(filename, "w") { |file| file.puts job.log }
          end
          system("less #{filename}")
        end
      end
    end
  end
end

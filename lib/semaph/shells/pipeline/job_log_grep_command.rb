require "fileutils"

module Semaph
  module Shells
    module Pipeline
      class JobLogGrepCommand
        attr_reader :usage, :help, :job_collection

        def initialize(job_collection)
          @job_collection = job_collection
          @usage = "<expression>"
          @help = "retrieve all logs and grep for text"
        end

        def execute(expression)
          base = "tmp/logs/pipeline/#{job_collection.pipeline.id}"
          FileUtils.mkdir_p(base)
          @job_collection.all.each do |job|
            unless job.finished?
              puts "skipping incomplete job #{job.id}"
              next
            end
            filename = "#{base}/#{job.id}.log"
            unless File.exist?(filename)
              puts "retrieving log for job #{job.id}"
              File.open(filename, "w") { |file| file.puts job.log }
            end
          end
          system("ag #{expression} #{base} | less")
        end
      end
    end
  end
end

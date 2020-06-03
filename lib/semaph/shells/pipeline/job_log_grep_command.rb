require "fileutils"

module Semaph
  module Shells
    module Pipeline
      class JobLogGrepCommand
        attr_reader :usage, :help, :job_collection

        def initialize(job_collection, scope)
          @job_collection = job_collection
          @scope = scope
          @usage = "<expression>"
          @help = "retrieve logs for #{scope} jobs and grep for text"
        end

        def execute(expression)
          base = "tmp/logs/pipeline/#{job_collection.pipeline.id}"
          FileUtils.mkdir_p(base)
          @job_collection.send(@scope).each do |job|
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

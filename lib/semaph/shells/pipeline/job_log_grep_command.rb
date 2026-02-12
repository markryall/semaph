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
          @job_collection.send(@scope).each do |job|
            unless job.finished?
              puts "skipping incomplete job #{job.id}"
              next
            end
            job.write_log(base)
          end
          if `which ag`.length.positive?
            system("ag #{expression} #{base} --nofilename --nonumber")
          else
            system("grep -r #{expression} #{base}")
          end
        end
      end
    end
  end
end

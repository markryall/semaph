module Semaph
  module Shells
    module Pipeline
      class JobsPollCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @help = "poll jobs"
        end

        def execute(_whatever)
          while incomplete_jobs.count.positive?
            puts "#{incomplete_jobs.count} incomplete jobs remaining:"
            describe_jobs(incomplete_jobs)
            sleep 20
            @job_collection.reload
          end
          puts "All jobs have completed:"
          describe_jobs(@job_collection.all)
        end

        private

        def describe_jobs(collection)
          collection.each { |job| puts job.description }
        end

        def incomplete_jobs
          @job_collection.all.reject { |job| job.status == "FINISHED" }
        end
      end
    end
  end
end

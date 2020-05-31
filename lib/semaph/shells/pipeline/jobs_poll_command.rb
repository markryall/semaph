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
            incomplete_jobs.each { |job| puts job.description }
            sleep 5
            @job_collection.reload
          end
          puts "All jobs have completed:"
          @job_collection.all.each { |job| puts job.description }
        end

        private

        def incomplete_jobs
          @job_collection.all.reject { |job| job.status == "FINISHED" }
        end
      end
    end
  end
end

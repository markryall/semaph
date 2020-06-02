module Semaph
  module Shells
    module Pipeline
      class JobsPollCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @help = "poll jobs"
          @can_notify = !`which terminal-notifier`.chomp.empty?
        end

        def execute(_whatever)
          incomplete_jobs = @job_collection.incomplete
          while incomplete_jobs.count.positive?
            puts "#{incomplete_jobs.count} incomplete jobs remaining:"
            incomplete_jobs.each { |job| puts job.description }
            failed_jobs = @job_collection.failed
            if failed_jobs.count.positive?
              puts "Some jobs have already failed:"
              failed_jobs.each { |job| puts job.description }
              `terminal-notifier -group semaph -message "#{failed_jobs.count} jobs have failed" -title "Job failures"` if @can_notify
              return
            end
            sleep 20
            @job_collection.reload
            incomplete_jobs = @job_collection.incomplete
          end
          @job_collection.all.each_with_index do |job, index|
            puts "#{index + 1} #{job.description}"
          end
          `terminal-notifier -group semaph -message "All jobs have completed" -title "Workflow completed"` if @can_notify
        end
      end
    end
  end
end

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
          while @job_collection.incomplete.count.positive?
            report_incomplete(@job_collection.incomplete_jobs)
            if @job_collection.failed.count.positive?
              report_failures(@job_collection.failed)
              return
            end
            sleep 20
            @job_collection.reload
          end
          report_final
        end

        private

        def report_final
          @job_collection.all.each_with_index do |job, index|
            puts "#{index + 1} #{job.description}"
          end
          notify("Workflow completed", "All jobs have completed")
        end

        def report_incomplete(incomplete_jobs)
          puts "#{incomplete_jobs.count} incomplete jobs remaining:"
          incomplete_jobs.each { |job| puts job.description }
        end

        def report_failures(failed_jobs)
          puts "Some jobs have already failed:"
          failed_jobs.each { |job| puts job.description }
          notify("Job Failures", "#{failed_jobs.count} jobs have failed")
        end

        def notify(title, message)
          return unless @can_notify

          `terminal-notifier -group semaph -message "#{message}" -title "#{title}"`
        end
      end
    end
  end
end

require "semaph/formatting"

module Semaph
  module Shells
    module Pipeline
      class JobsPollCommand
        attr_reader :usage, :help, :job_collection

        def initialize(job_collection, list_command)
          @job_collection = job_collection
          @list_command = list_command
          @help = "poll jobs"
          @can_notify = !`which terminal-notifier`.chomp.empty?
        end

        def execute(_whatever)
          while job_collection.incomplete.count.positive?
            report_incomplete(job_collection.incomplete)
            if job_collection.failed.count.positive?
              report_failures(job_collection.failed)
              return
            end
            sleep 20
            job_collection.reload
          end
          report_final
        end

        private

        def report_final
          @list_command.execute
          failed_job_count = job_collection.failed.count
          notify(
            "Workflow completed",
            "#{job_collection.pipeline.workflow.description} completed with #{failed_job_count} failed jobs",
            failed_job_count.positive?,
          )
        end

        def report_incomplete(incomplete_jobs)
          puts "polling #{job_collection.pipeline.workflow.description}"
          puts "#{incomplete_jobs.count} incomplete jobs remaining:"
          incomplete_jobs.each { |job| puts job.description }
        end

        def report_failures(failed_jobs)
          puts "Some jobs have failed:"
          failed_jobs.each { |job| puts job.description }
          notify("Job Failures", "#{failed_jobs.count} jobs have failed", true)
        end

        def notify(title, message, failed)
          return unless @can_notify

          sound = failed ? "basso" : "blow"

          `terminal-notifier -group semaph -message "#{message}" -title "#{title}" -sound #{sound}`
        end
      end
    end
  end
end

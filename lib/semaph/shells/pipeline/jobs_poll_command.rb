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

        def execute(_whatever = nil)
          report_and_reload(15) while job_collection.incomplete.count.positive? && job_collection.failed.count.zero?
          report_final
        end

        private

        def report_and_reload(period)
          period.times { report_incomplete }
          job_collection.reload
        end

        def report_final
          @list_command.execute
          failed_job_count = job_collection.failed.count
          notify(
            "Workflow completed",
            "#{job_collection.pipeline.workflow.description} completed with #{failed_job_count} failed jobs",
            failed_job_count.positive?,
          )
        end

        def report_incomplete
          base = [nil, elapsed, report_ratio, job_collection.pipeline.workflow.description].join(" ")
          erase base
        end

        def report_ratio
          [
            job_collection.incomplete.count.to_s.rjust(2, "0"),
            job_collection.all.count.to_s.rjust(2, "0"),
          ].join("/")
        end

        def elapsed
          duration = Time.now.to_i - job_collection.created_at.to_i
          mins = duration / 60
          secs = duration % 60
          [mins.to_s.rjust(2, "0"), secs.to_s.rjust(2, "0")].join(":")
        end

        def erase(string)
          print string
          print "\b" * string.length
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

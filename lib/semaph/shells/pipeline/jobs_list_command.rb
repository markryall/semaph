require "semaph/formatting"

module Semaph
  module Shells
    module Pipeline
      class JobsListCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @help = "list jobs"
        end

        def execute(_whatever = nil)
          @job_collection.reload
          @job_collection.all.each_with_index do |job, index|
            puts [::Semaph::Formatting.index(index + 1), job.description].join(" ")
          end
        end
      end
    end
  end
end

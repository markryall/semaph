require 'rainbow'

module Semaph
  module Shells
    module Pipeline
      class JobsListCommand
        attr_reader :usage, :help

        def initialize(job_collection)
          @job_collection = job_collection
          @help = "list jobs"
        end

        def execute(_whatever)
          @job_collection.reload
          @job_collection.all.each_with_index do |job, index|
            puts [display_index(index + 1), job.description].join(" ")
          end
        end

        def display_index(index)
          Rainbow(index.to_s.rjust(2)).yellow
        end
      end
    end
  end
end

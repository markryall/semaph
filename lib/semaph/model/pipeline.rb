require "semaph/model/job_collection"

module Semaph
  module Model
    class Pipeline
      attr_reader :workflow, :raw, :id, :yaml, :state, :result

      def initialize(workflow, raw)
        @workflow = workflow
        @raw = raw
        @id = raw["ppl_id"]
        @yaml = raw["yaml_file_name"]
        @state = raw["state"]
        @result = raw["result"]
      end

      def job_collection
        JobCollection.new(self)
      end
    end
  end
end

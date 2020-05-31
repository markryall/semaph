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
        %w[created done pending queuing running stopping].each do |name|
          extract_time(name)
        end
      end

      def job_collection
        JobCollection.new(self)
      end

      private

      def extract_time(name)
        key = "#{name}_at"
        return if raw[key]["seconds"].zero?

        instance_variable_set("@#{key}", Time.at(raw[key]["seconds"]))
      end
    end
  end
end

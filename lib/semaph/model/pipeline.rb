module Semaph
  module Model
    class Pipeline
      attr_reader :workflow, :raw, :yaml, :state, :result

      def initialize(workflow, raw)
        @workflow = workflow
        @raw = raw
        @yaml = raw["yaml_file_name"]
        @state = raw["state"]
        @result = raw["result"]
      end
    end
  end
end

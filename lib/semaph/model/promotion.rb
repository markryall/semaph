module Semaph
  module Model
    class Promotion
      attr_reader :pipeline, :raw

      def initialize(pipeline, raw)
        @pipeline = pipeline
        @raw = raw
      end

      def description
        raw.inspect
      end
    end
  end
end

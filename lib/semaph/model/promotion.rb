require "semaph/formatting"

module Semaph
  module Model
    class Promotion
      attr_reader :pipeline, :raw

      def initialize(pipeline, raw)
        @pipeline = pipeline
        @raw = raw
        @name = raw["name"]
        @status = raw["status"]
        @triggered_at = Time.at(raw["triggered_at"]["seconds"])
      end

      def description
        [
          status_icon,
          Semaph::Formatting.time(@triggered_at),
          @name,
        ].join(" ")
      end

      def status_icon
        return "🟢" if @status == "passed"

        "🔴"
      end
    end
  end
end

require "semaph/model/job_collection"
require "semaph/model/promotion_collection"

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

      def promote(name)
        workflow.project.client.promote(id, name)
      end

      def job_collection
        @job_collection ||= JobCollection.new(self)
      end

      def promotion_collection
        @promotion_collection ||= PromotionCollection.new(self)
      end

      def description
        [
          icon,
          time,
          yaml,
        ].compact.join(" ")
      end

      def done?
        @state == "DONE"
      end

      def icon
        return "🔵" unless done?

        return "⛔" if @result == "STOPPED"

        return "🟢" if @result == "PASSED"

        "🔴"
      end

      private

      def time
        return hours_minutes_seconds(@done_at.to_i - @created_at.to_i) if done?

        hours_minutes_seconds(Time.now.to_i - @created_at.to_i)
      end

      def hours_minutes_seconds(total_seconds)
        seconds = total_seconds % 60
        minutes = (total_seconds / 60) % 60
        hours = total_seconds / (60 * 60)

        format("%02<hours>d:%02<minutes>d:%02<seconds>d", hours: hours, minutes: minutes, seconds: seconds)
      end

      def extract_time(name)
        key = "#{name}_at"
        return if raw[key]["seconds"].zero?

        instance_variable_set("@#{key}", Time.at(raw[key]["seconds"]))
      end
    end
  end
end

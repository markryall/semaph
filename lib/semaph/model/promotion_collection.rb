require "semaph/model/promotion"

module Semaph
  module Model
    class PromotionCollection
      attr_reader :all, :pipeline

      def initialize(pipeline)
        @pipeline = pipeline
      end

      def reload
        workflow = @pipeline.workflow
        project = workflow.project
        @all = project.client.promotions(@pipeline.id).map do |promotion_response|
          Promotion.new(@pipeline, promotion_response)
        end
      end
    end
  end
end

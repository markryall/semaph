module Semaph
  module Shells
    module Pipeline
      class PromotionsListCommand
        attr_reader :usage, :help

        def initialize(promotion_collection)
          @promotion_collection = promotion_collection
          @help = "list promotions"
        end

        def execute(_whatever)
          @promotion_collection.reload
          @promotion_collection.all.each_with_index do |promotion, index|
            puts "#{index + 1} #{promotion.description}"
          end
        end
      end
    end
  end
end

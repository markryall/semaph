require "semaph/model/project"

module Semaph
  module Model
    class ProjectCollection
      attr_reader :all

      def initialize(client)
        @client = client
      end

      def reload
        @all = @client.projects.map do |content|
          Project.new @client, content
        end
      end
    end
  end
end

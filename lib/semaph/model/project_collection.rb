require "semaph/model/project"

module Semaph
  module Model
    class ProjectCollection
      include Enumerable

      def initialize(client)
        @client = client
        reload
      end

      def each
        @projects.each { |project| yield project }
      end

      def reload
        @projects = @client.projects.map do |content|
          Project.new @client, content
        end
      end
    end
  end
end

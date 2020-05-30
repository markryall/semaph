require "semaph/model/workflow_collection"

module Semaph
  module Model
    class Project
      attr_reader :client, :raw, :id, :name

      def initialize(client, raw)
        @client = client
        @raw = raw
        @id = raw["metadata"]["id"]
        @name = raw["metadata"]["name"]
      end

      def workflow_collection
        WorkflowCollection.new(@client, self)
      end
    end
  end
end

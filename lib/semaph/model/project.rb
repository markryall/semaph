require "semaph/model/workflow_collection"

module Semaph
  module Model
    class Project
      GITHUB_REGGEXP = %r{git@github.com:(.*)/(.*).git}

      attr_reader :client, :raw, :id, :name

      def initialize(client, raw)
        @client = client
        @raw = raw
        @id = raw["metadata"]["id"]
        @name = raw["metadata"]["name"]
        repo = raw["spec"]["repository"]["url"]
        match = GITHUB_REGGEXP.match(repo)
        return unless match

        @repo_owner = match[1]
        @repo_name = match[2]
      end

      def github_url
        return nil unless @repo_owner && @repo_name

        "https://github.com/#{@repo_owner}/#{@repo_name}"
      end

      def workflow_collection
        @workflow_collection ||= WorkflowCollection.new(self)
      end
    end
  end
end

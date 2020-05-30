module Semaph
  module Model
    class Workflow
      attr_reader :raw, :id, :sha, :branch, :created_at

      def initialize(client, raw)
        @client = client
        @raw = raw
        @id = raw["wf_id"]
        @sha = raw["commit_sha"]
        @created_at = Time.at(raw["created_at"]["seconds"].to_i)
        @branch = raw["branch_name"]
        # @summary = `git log -n 1 --format="%h %an %ci %s" #{sha}`
      end
    end
  end
end

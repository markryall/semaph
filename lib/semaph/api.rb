require "faraday"
require "json"

module Semaph
  # Refer to https://docs.semaphoreci.com/reference/api-v1alpha/
  class Api
    def initialize(token, host)
      @token = token
      @base = "https://#{host}/api/v1alpha"
    end

    def projects
      get "projects"
    end

    def workflows(project_id, branch_name)
      get "plumber-workflows", { project_id: project_id, branch_name: branch_name }
    end

    def pipelines(project_id, options)
      get "pipelines", options.merge({ project_id: project_id })
    end

    def pipeline(id)
      get "pipelines/#{id}", { detailed: true }
    end

    def job(id)
      get "jobs/#{id}"
    end

    private

    def get(path, params = {})
      url = "#{@base}/#{path}"
      puts url if ENV["SEMAPH_DEBUG"]
      response = Faraday.get(url, params, headers)
      check_response(response, url).tap do |hash|
        pp hash if ENV["SEMAPH_DEBUG"]
      end
    end

    def headers
      {
        "Authorization" => "Token #{@token}",
        "Content-Type" => "application/json",
        "Accept" => "application/json",
      }
    end

    def check_response(response, url)
      return JSON.parse(response.body) if response.status == 200

      puts "http response #{response.status} received for #{url}:\n#{response.body}"
      exit 1
    end
  end
end

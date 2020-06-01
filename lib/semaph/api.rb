require "faraday"
require "json"

module Semaph
  # Refer to https://docs.semaphoreci.com/reference/api-v1alpha/
  class Api
    attr_reader :host, :name

    def initialize(token, host)
      @token = token
      @host = host
      @name = host.split(".").first
      @base = "https://#{host}/api/v1alpha"
    end

    def projects
      get "projects"
    end

    def workflows(project_id)
      get "plumber-workflows", { project_id: project_id }
    end

    def workflow(workflow_id)
      get "plumber-workflows/#{workflow_id}"
    end

    def stop_workflow(workflow_id)
      post "plumber-workflows/#{workflow_id}/terminate"
    end

    def rerun_workflow(workflow_id)
      post "plumber-workflows/#{workflow_id}/reschedule?request_token=#{workflow_id}"
    end

    def pipelines(options)
      get "pipelines", options
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

    def post(path, params = {})
      url = "#{@base}/#{path}"
      response = Faraday.post(url, params.to_json, headers)
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

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
      @host_url = "https://#{host}"
      @base = "#{@host_url}/api/v1alpha"
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

    def promotions(pipeline_id)
      get "promotions", { pipeline_id: pipeline_id }
    end

    def promote(pipeline_id, name)
      post "promotions", { pipeline_id: pipeline_id, name: name }
    end

    def job(id)
      get "jobs/#{id}"
    end

    def stop_job(id)
      post "jobs/#{id}/stop"
    end

    def job_log(id)
      get_raw "jobs/#{id}/plain_logs.json"
    end

    private

    def get_raw(path, params = {})
      url = "#{@host_url}/#{path}"
      puts url if ENV["SEMAPH_DEBUG"]
      response = Faraday.get(url, params, { "Authorization" => "Token #{@token}" })
      check_response(response, url)
    end

    def get(path, params = {})
      url = "#{@base}/#{path}"
      puts url if ENV["SEMAPH_DEBUG"]
      response = Faraday.get(url, params, headers)
      JSON.parse(check_response(response, url)).tap do |hash|
        pp hash if ENV["SEMAPH_DEBUG"]
      end
    end

    def post(path, params = {})
      url = "#{@base}/#{path}"
      response = Faraday.post(url, params.to_json, headers)
      JSON.parse(check_response(response, url)).tap do |hash|
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
      return response.body if response.status == 200

      puts "http response #{response.status} received for #{url}:\n#{response.body}"
      exit 1
    end
  end
end

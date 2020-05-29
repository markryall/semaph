module Semaph
  class ProjectsList
    attr_reader :usage, :help

    def initialize(api)
      @api = api
      @help = "list available projects"
    end

    def execute(_whatever)
      @api.projects.each do |project|
        puts project["metadata"]["name"]
      end
    end
  end
end

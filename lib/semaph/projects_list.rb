module Semaph
  class ProjectsList
    attr_reader :usage, :help

    def initialize(api, parent_state)
      @api = api
      @parent_state = parent_state
      @help = "list available projects"
    end

    def execute(_whatever)
      @parent_state[:projects] = @api.projects.map do |project|
        {
          id: project["metadata"]["id"],
          name: project["metadata"]["name"],
        }
      end
      @parent_state[:projects].each do |project|
        puts project[:name]
      end
    end
  end
end

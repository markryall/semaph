require "semaph/project_context"

module Semaph
  class ProjectsSelect
    attr_reader :usage, :help

    def initialize(api, parent_state)
      @api = api
      @parent_state = parent_state
      @usage = "<project>"
      @help = "choose project"
    end

    def completion(text)
      @parent_state[:projects].map { |project| project[:name] }.grep(/^#{text}/).sort
    end

    def execute(name)
      selected_project = @parent_state[:projects].find do |project|
        project[:name] == name
      end
      ProjectContext.new(@api, selected_project).push
    end
  end
end

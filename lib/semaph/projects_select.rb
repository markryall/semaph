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
      @parent_state[:projects].map do |project|
        project[:name]
      end.grep(/^#{text}/).sort
    end

    def execute(name)
      selected_project = @parent_state[:projects].find do |project|
        project[:name] == name
      end
      puts "you have selected #{selected_project[:id]}"
    end
  end
end

module Semaph
  class ListCredentials
    attr_reader :usage, :help

    def initialize
      @help = "list available credentials"
    end

    def execute(_whatever)
      puts "todo"
    end
  end
end

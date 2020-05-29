module Semaph
  class ChooseCredentials
    attr_reader :usage, :help

    def initialize(credentials)
      @credentials = credentials
      @usage = "<credential>"
      @help = "choose credentials"
    end

    def completion(text)
      @credentials.keys.grep(/^#{text}/).sort
    end

    def execute(name)
      puts "you chose #{name}"
    end
  end
end

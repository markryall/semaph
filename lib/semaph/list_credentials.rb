module Semaph
  class ListCredentials
    attr_reader :usage, :help

    def initialize(credentials)
      @credentials = credentials
      @help = "list available credentials"
    end

    def execute(_whatever)
      @credentials.each_key do |name|
        puts "#{name} (#{@credentials[name]['host']})"
      end
    end
  end
end

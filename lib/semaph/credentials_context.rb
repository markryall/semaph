require "shell_shock/context"
require "semaph/list_credentials"
require "semaph/choose_credentials"

module Semaph
  class CredentialsContext
    include ShellShock::Context

    def initialize(credentials)
      @credentials = credentials
      @prompt = "semaph > "
      add_command ListCredentials.new(credentials), "ls"
      add_command ChooseCredentials.new(credentials), "cd"
    end
  end
end

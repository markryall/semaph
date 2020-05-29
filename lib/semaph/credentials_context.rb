require "shell_shock/context"
require "semaph/list_credentials"

module Semaph
  class CredentialsContext
    include ShellShock::Context

    def initialize
      @prompt = "semaph > "
      add_command ListCredentials.new, "ls"
    end
  end
end

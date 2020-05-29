require "semaph/version"
require "semaph/credentials_context"

module Semaph
  class Error < StandardError; end

  def self.console
    CredentialsContext.new.push
  end
end

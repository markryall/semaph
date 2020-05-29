require "semaph/organisation_context"

module Semaph
  class OrganisationsSelect
    attr_reader :usage, :help

    def initialize(organisations)
      @organisations = organisations
      @usage = "<organisation>"
      @help = "choose organisation"
    end

    def completion(text)
      @organisations.keys.grep(/^#{text}/).sort
    end

    def execute(name)
      OrganisationContext.new(@organisations[name]).push
    end
  end
end

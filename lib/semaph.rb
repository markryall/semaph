require "semaph/version"
require "semaph/shells/organisations/organisations_shell"
require "semaph/shells/organisation/organisation_shell"
require "yaml"

module Semaph
  class Error < StandardError; end

  def self.console
    yaml_path = File.join(File.expand_path("~"), ".sem.yaml")
    raise "Please install the sem tool and authenticate to semaphoreci.com" unless File.exist?(yaml_path)

    sem_config = YAML.load_file(yaml_path)
    contexts = sem_config["contexts"]

    if contexts.count == 1
      Shells::Organisation::OrganisationShell.new(contexts.values.first).push
    else
      Shells::Organisations::OrganisationsShell.new(contexts).push
    end
  end
end

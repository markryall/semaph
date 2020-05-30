require "semaph/version"
require "semaph/shells/organisations/organisations_shell"
require "yaml"

module Semaph
  class Error < StandardError; end

  def self.console
    yaml_path = File.join(File.expand_path("~"), ".sem.yaml")
    raise "Please install the sem tool and authenticate to semaphoreci.com" unless File.exist?(yaml_path)

    sem_config = YAML.load_file(yaml_path)
    Shells::Organisations::OrganisationsShell.new(sem_config["contexts"]).push
  end
end

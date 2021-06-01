require "semaph/client"
require "semaph/model/project"
require "semaph/version"
require "semaph/shells/organisations/organisations_shell"
require "semaph/shells/organisation/organisation_shell"
require "semaph/shells/project/project_shell"
require "yaml"

module Semaph
  class Error < StandardError; end

  def self.console
    organisations = load_organisations
    config = load_config

    if config
      console_with_config(organisations, config)
    elsif organisations.count == 1
      Shells::Organisation::OrganisationShell.new(organisations.first).push
    else
      Shells::Organisations::OrganisationsShell.new(organisations).push
    end
  end

  def self.console_with_config(organisations, config)
    organisation = organisations.find { |o| o["host"] == config[:host] }

    Shells::Project::ProjectShell.new(
      Model::Project.new(
        ::Semaph::Client.new(
          organisation["auth"]["token"],
          organisation["host"],
        ),
        config[:project],
      ),
    ).push
  end

  def self.load_organisations
    yaml_path = File.join(File.expand_path("~"), ".sem.yaml")

    unless File.exist?(yaml_path) && organisations
      puts "Please install the sem tool and authenticate to semaphoreci.com"
      exit 1
    end

    YAML.load_file(yaml_path)["contexts"].values
  end

  def self.load_config
    return nil unless File.exist?(".semaph")

    YAML.load_file(".semaph")
  end
end

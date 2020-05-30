require_relative "lib/semaph/version"

Gem::Specification.new do |spec|
  spec.name          = "semaph"
  spec.version       = Semaph::VERSION
  spec.authors       = ["Mark Ryall"]
  spec.email         = ["mark@ryall.name"]

  spec.summary       = "client for semaphore 2"
  spec.description   = "api client and shell for api"
  spec.homepage      = "http://github.com/markryall/semaph"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "rainbow"
  spec.add_dependency "shell_shock"

  spec.add_development_dependency "pry"
end

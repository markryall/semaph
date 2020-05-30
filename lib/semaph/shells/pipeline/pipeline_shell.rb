require "shell_shock/context"

module Semaph
  module Shells
    module Pipeline
      class PipelineShell
        include ShellShock::Context

        def initialize(pipeline)
          @pipeline = pipeline
          workflow = pipeline.workflow
          project = workflow.project
          @prompt = "🏗  #{project.client.host} #{project.name} #{workflow.id} #{pipeline.yaml} > "
        end
      end
    end
  end
end

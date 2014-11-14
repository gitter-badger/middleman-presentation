# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Run command
      class Export < Base
        register ExportPresentation, 'presentation', 'presentation', 'Export presentation'

        default_command :presentation
      end
    end
  end
end

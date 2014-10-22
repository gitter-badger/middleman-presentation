# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Build presentation
      class Serve < Base
        register ServePresentation, 'presentation', 'presentation', 'Serve presentation'

        default_command :presentation
      end
    end
  end
end

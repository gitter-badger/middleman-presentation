# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Create < Thor
        register(CreateTheme, 'theme', 'theme NAME', 'Create a new theme named NAMED')
        register(CreatePresentation, 'presentation', 'presentation [DIR]', 'Initialize a new presentation in DIR (default: $PWD)')

        default_command :presentation
      end
    end
  end
end

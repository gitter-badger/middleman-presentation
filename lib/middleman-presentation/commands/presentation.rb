# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation' command for the middleman CLI.
      class Presentation < Thor
        include Thor::Actions

        def self.check_unknown_options?(*)
          false
        end

        namespace :presentation

        desc 'presentation ', 'Initialize a new presentation'
        def presentation(*)
          warn('The use of this command is deprecated. Please use `middleman-presentation init presentation` instead.')
          exit 1
        end
      end
    end
  end
end

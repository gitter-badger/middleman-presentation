# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Run command
      class Runner < Thor
        desc 'init', 'Initialize system, presentation, ...'
        subcommand 'init', Init

        register(CreateTheme, 'theme', 'theme NAME', 'Create a new theme named NAMED')

        desc 'config', 'Show configuration'
        option :show_defaults, type: :boolean, desc: 'Show default configuration'
        def config
          if options[:show_defaults]
            capture :stderr do
              puts Middleman::Presentation::PresentationConfig.new(file: nil).to_s
            end
          else
            puts Middleman::Presentation.config.to_s
          end
        end
      end
    end
  end
end

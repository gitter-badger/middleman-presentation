# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'build presentation' command for the middleman CLI.
      class ServePresentation < BaseGroup
        include Thor::Actions

        desc Middleman::Presentation.t('views.presentation.serve.title')

        def initialize_generator
          enable_debug_mode
        end

        def build_presentation
          Middleman::Presentation.logger.info Middleman::Presentation.t(
            'views.presentation.build.headline',
            title: @title
          )

          cmd = []
          cmd << 'middleman server'
          cmd << '--verbose' if options[:debug_mode]

          run(cmd.join(' '))
        end
      end
    end
  end
end

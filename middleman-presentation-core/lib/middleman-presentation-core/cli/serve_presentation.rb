# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'build presentation' command for the middleman CLI.
      class ServePresentation < BaseGroup
        include Thor::Actions

        class_option :network_port, type: :numeric, default: Middleman::Presentation.config.network_port, desc: Middleman::Presentation.t('views.presentation.serve.options.network_port')
        class_option :network_interface, default: Middleman::Presentation.config.network_interface, desc: Middleman::Presentation.t('views.presentation.serve.options.network_interface')

        def initialize_generator
          enable_debug_mode
        end

        def build_presentation
          Middleman::Presentation.logger.info Middleman::Presentation.t(
            'views.presentation.serve.headline',
            title: Middleman::Presentation.config.title
          )

          cmd = []
          cmd << 'middleman server'
          cmd << "-p #{options[:network_port]}"
          cmd << "-h #{options[:network_interface]}"
          cmd << '--verbose' if options[:debug_mode]

          run(cmd.join(' '))
        end
      end
    end
  end
end

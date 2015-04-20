# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'build presentation' command for the middleman CLI.
      class ServePresentation < BaseGroup
        include Thor::Actions

        class_option :network_port, type: :numeric, default: Middleman::Presentation.config.network_port, desc: Middleman::Presentation.t('views.presentation.serve.options.network_port'), alias: '-p'
        class_option :network_interface, default: Middleman::Presentation.config.network_interface, desc: Middleman::Presentation.t('views.presentation.serve.options.network_interface'), alias: '-i'
        class_option :open_in_browser, type: :boolean, default: Middleman::Presentation.config.open_in_browser, desc: Middleman::Presentation.t('views.presentation.serve.options.open_in_browser'), alias: '-o'

        def initialize_generator
          enable_debug_mode
        end

        def build_presentation
          Middleman::Presentation.logger.info Middleman::Presentation.t(
            'views.presentation.serve.headline',
            title: Middleman::Presentation.config.title
          )

          Launchy.open(Addressable::URI.parse("http://#{options[:network_interface]}:#{options[:network_port]}")) if options[:open_in_browser]

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

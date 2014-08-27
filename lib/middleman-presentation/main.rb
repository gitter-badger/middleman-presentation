# encoding: utf-8
# Main
module Middleman
  # Presentation extension
  module Presentation
    @config                      = PresentationConfig.new
    @logger                      = Logger.new
    @helpers_manager             = HelpersManager.new
    @assets_manager              = AssetsManager.new
    @frontend_components_manager = FrontendComponentsManager.new
    @plugins_manager             = PluginsManager.new(whitelist: @config.plugins_whitelist, blacklist: @config.plugins_blacklist)
    @locale_configurator         = LocaleConfigurator.new(path: File.expand_path('../../../locales', __FILE__), default_locale: @config.cli_language)

    ###                                                               ###
    # Keep in mind that there are methods at the end of the file which: #
    # * load bower assets                                               #
    # * activate plugins                                                #
    ###                                                               ###

    class << self
      attr_reader :config, :logger, :plugins_manager, :frontend_components_manager, :helpers_manager, :assets_manager, :locale_configurator

      def root_path
        File.expand_path '../../../', __FILE__
      end

      def t(*args, &block)
        locale_configurator.t(*args, &block)
      end

      def stylable_files
        paths = []

        paths << '../../../templates/slides/*.tt'
        paths << '../../../templates/predefined_slides.d/*.tt'

        paths.concat ['../../../templates/source/'].product(%w(layout.erb index.html.erb)).map(&:join)

        Rake::FileList.new(
          paths.map { |f| File.expand_path(f, __FILE__) }
        )
      end

      def load_plugins
        plugins_manager.load_plugins if config.plugins_enable == true
      end

      def load_default_assets_in_bower_directory
        assets_manager.load_default_components(config.bower_directory)
      end

      def add_default_components
        Middleman::Presentation.frontend_components_manager.add(
          name: 'jquery',
          version: '~1.11',
          javascripts: %w(dist/jquery)
        )

        Middleman::Presentation.frontend_components_manager.add(
          name: 'reveal.js',
          version: 'latest',
          javascripts: %w(lib/js/head.min js/reveal.min)
        )

        Middleman::Presentation.frontend_components_manager.add(
          name: 'lightbox2',
          github: 'dg-vrnetze/revealjs-lightbox2',
          javascripts: %w(js/lightbox)
        )

        Middleman::Presentation.frontend_components_manager.add(
          name: 'middleman-presentation-theme-common',
          github: 'dg-vrnetze/middleman-presentation-theme-common',
          stylesheets: %w(stylesheets/middleman-presentation-theme-common),
          javascripts: %w(javascripts/middleman-presentation-theme-common)
        )

        # rubocop:disable Style/GuardClause
        unless Middleman::Presentation.config.components.blank?
          Middleman::Presentation.frontend_components_manager.add(
            Middleman::Presentation.config.components
          )
        end
        # rubocop:enable Style/GuardClause

        if Middleman::Presentation.config.theme.blank?
          Middleman::Presentation.frontend_components_manager.add(
            name: 'middleman-presentation-theme-default',
            github: 'maxmeyer/middleman-presentation-theme-default',
            stylesheets: %w(stylesheets/middleman-presentation-theme-default)
          )
        else
          Middleman::Presentation.frontend_components_manager.add(
            Middleman::Presentation.config.theme
          )
        end
      end
    end
  end
end

Middleman::Presentation.load_default_assets_in_bower_directory
Middleman::Presentation.add_default_components
Middleman::Presentation.load_plugins

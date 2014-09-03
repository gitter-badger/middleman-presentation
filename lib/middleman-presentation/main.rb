# encoding: utf-8
# Main
module Middleman
  # Presentation extension
  module Presentation
    @config                      = PresentationConfig.new
    @logger                      = Logger.new
    @helpers_manager             = HelpersManager.new
    @frontend_components_manager = FrontendComponentsManager.new
    @assets_manager              = AssetsManager.new
    @plugins_manager             = PluginsManager.new(whitelist: @config.plugins_whitelist, blacklist: @config.plugins_blacklist)
    @locale_configurator         = LocaleConfigurator.new(path: File.expand_path('../../../locales', __FILE__), default_locale: @config.cli_language)

    class << self
      attr_reader :config, :logger, :plugins_manager, :frontend_components_manager, :helpers_manager, :assets_manager, :locale_configurator

      def not_matching_regular_expression
        @not_matching_regular_expression ||= Regexp.new(SecureRandom.hex)
      end

      def root_path
        File.expand_path '../../../', __FILE__
      end

      def t(*args, &block)
        locale_configurator.t(*args, &block)
      end

      def underline_character
        '#'
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
    end
  end
end

Middleman::Presentation::DefaultLoader.new.load

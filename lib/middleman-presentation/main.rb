# encoding: utf-8
# Main
module Middleman
  # Presentation extension
  module Presentation
    @config                      = PresentationConfig.new
    @logger                      = Logger.new
    @frontend_components_manager = FrontendComponentsManager.new
    @helpers_manager             = HelpersManager.new
    @assets_manager              = AssetsManager.new(bower_directory: @config.bower_directory)
    @plugins_manager             = PluginsManager.new(whitelist: @config.plugins_whitelist, blacklist: @config.plugins_blacklist)
    @locale_configurator         = LocaleConfigurator.new(path: File.expand_path('../../../locales', __FILE__))

    class << self
      attr_reader :config, :logger, :plugins_manager, :frontend_components_manager, :helpers_manager, :assets_manager, :locale_configurator

      def root_path
        File.expand_path '../../../', __FILE__
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

      private

    end
  end
end

Middleman::Presentation.load_plugins

# encoding: utf-8
# Main
module Middleman
  # Presentation extension
  module Presentation
    @config                      = PresentationConfig.new
    @logger                      = Logger.new
    @plugins_manager             = PluginsManager.new(whitelist: @config.plugins_whitelist, blacklist: @config.plugins_blacklist)
    @frontend_components_manager = FrontendComponentsManager.new
    @helpers_manager             = HelpersManager.new

    class << self
      attr_reader :config, :logger, :plugins_manager, :frontend_components_manager, :helpers_manager

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

      def configure_i18n
        I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
        I18n.load_path = Dir[::File.join(Middleman::Presentation.root_path, 'locales', '*.yml')]
        I18n.backend.load_translations
        I18n.available_locales = available_locales
        I18n.enforce_available_locales = false
      end

      private
      
      def available_locales
        Dir.glob(File.join(Middleman::Presentation.root_path, 'locales', '*.yml')).map { |f| File.basename(f, '.yml').to_sym }
      end
    end
  end
end

Middleman::Presentation.configure_i18n
Middleman::Presentation.load_plugins

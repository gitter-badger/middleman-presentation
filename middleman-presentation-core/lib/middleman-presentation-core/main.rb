# encoding: utf-8
# Main
module Middleman
  # Presentation extension
  module Presentation
    @logger                      = Logger.new
    @config                      = ApplicationConfig.new(merge_files: true)
    @helpers_manager             = HelpersManager.new
    @assets_manager              = AssetsManager.new
    @components_manager          = ComponentsManager.new
    @plugins_manager             = PluginsManager.new(creator: Plugin)
    @locale_configurator         = LocaleConfigurator.new(path: File.expand_path('../../../locales', __FILE__), default_locale: @config.cli_language)
    @debug_mode                  = false

    class << self
      attr_reader :config, :logger, :plugins_manager, :components_manager, :helpers_manager, :assets_manager, :locale_configurator

      private

      attr_accessor :debug_mode

      public

      def t(*args, &block)
        locale_configurator.t(*args, &block)
      end

      def underline_character
        '#'
      end

      def debug_mode_enabled?
        debug_mode == true
      end

      def enable_debug_mode
        self.debug_mode = true
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

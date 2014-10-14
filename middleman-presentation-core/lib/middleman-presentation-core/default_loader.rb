# encoding: utf-8
module Middleman
  module Presentation
    # Loads all default helpers, plugins, components
    class DefaultLoader
      private

      attr_reader :application

      public

      def initialize
        @application = Middleman::Presentation
      end

      def load
        # the first thing added here, will be the last thing
        # in application.scss and therefor takes precendence over
        # the latter
        load_theme
        load_components_required_in_config_file
        load_plugins
        load_assets_in_bower_directory
      end

      def load_plugins
        application.plugins_manager.activate_plugin(*application.config.plugins)
      end

      def load_components_required_in_config_file
        return if application.config.components.blank?
        
        application.frontend_components_manager.add(
          application.config.components
        )
      end

      def load_theme
        if application.config.theme.blank?
          application.frontend_components_manager.add(
            name: 'middleman-presentation-theme-default',
            github: 'maxmeyer/middleman-presentation-theme-default',
            importable_files: [
              %r{stylesheets/middleman-presentation-theme-default.scss$}
            ],
            loadable_files: [
              %r{.*\.png$}
            ]
          )
        else
          application.frontend_components_manager.add(
            application.config.theme
          )
        end
      end

      # Load default components
      def load_assets_in_bower_directory
        loadable_files = [
          /\.png$/,
          /\.gif$/,
          /\.jpg$/,
          /\.jpeg$/,
          /\.svg$/,
          /\.webp$/,
          /\.eot$/,
          /\.otf$/,
          /\.svc$/,
          /\.woff$/,
          /\.ttf$/,
        ]

        filesystem_list = FilesystemAssetList.new(
          directory: application.config.bower_directory,
          loadable_files: loadable_files,
        )

        components_list = Middleman::Presentation::FrontendComponentAssetList.new(
          components: application.frontend_components_manager.available_frontend_components, 
          directory: File.join(Dir.getwd, application.config.bower_directory)
        )

        application.assets_manager.load_from_list components_list
        application.assets_manager.load_from_list filesystem_list
      end
    end
  end
end

# encoding: utf-8
module Middleman
  module Presentation
    # Loads all default helpers, plugins, components
    class AssetsLoader
      private

      attr_reader :application, :root_directory

      public

      def initialize(root_directory: Dir.getwd)
        @application    = Middleman::Presentation
        @root_directory = root_directory
      end

      def load_for_bower_update
        activate_core_plugins
        activate_user_plugins

        add_components_required_in_config_file
        add_theme_component
      end

      def load_for_asset_aggregators
        activate_core_plugins
        activate_user_plugins

        add_components_required_in_config_file
        add_theme_component

        add_assets_from_components
      end

      def load_at_presentation_runtime
        add_assets_from_bower_directory

        activate_core_plugins
        activate_user_plugins

        add_components_required_in_config_file
        add_theme_component

        add_assets_from_components
      end

      private

      def activate_core_plugins
        application.plugins_manager.activate_plugin('middleman-presentation-helpers')
      end

      def activate_user_plugins
        application.plugins_manager.activate_plugin(*application.config.plugins)
      end

      def add_components_required_in_config_file
        return if application.config.components.blank?

        application.components_manager.add(
          application.config.components
        )
      end

      def add_theme_component
        return if application.config.theme.blank?

        application.components_manager.add FrontendComponent.new(**application.config.theme)
      end

      def add_assets_from_bower_directory
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
          /\.ttf$/
        ]

        application.components_manager.add AssetComponent.new(path: root_directory, loadable_files: loadable_files)
      end

      # Load default components
      def add_assets_from_components
        components_list = Middleman::Presentation::AssetList.new(
          application.components_manager.available_components
        )

        application.assets_manager.load_from_list components_list
      end
    end
  end
end

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
        load_plugins
        load_default_components
        load_assets_in_bower_directory
      end

      private

      def load_plugins
        application.plugins_manager.load_plugins if application.config.plugins_enable == true
      end

      def load_default_components
        # rubocop:disable Style/GuardClause
        unless application.config.components.blank?
          application.frontend_components_manager.add(
            application.config.components
          )
        end
        # rubocop:enable Style/GuardClause
        if application.config.theme.blank?
          application.frontend_components_manager.add(
            name: 'middleman-presentation-theme-default',
            github: 'maxmeyer/middleman-presentation-theme-default',
            importable_files: [
              %r{stylesheets/middleman-presentation-theme-default.scss$},
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
          /notes\.html/,
          %r{reveal\.js/.*/.*\.js$},
        ]

        output_directories = {
          /notes\.html$/ => Pathname.new('javascripts'),
          /pdf\.css$/ => Pathname.new('stylesheets')
        }

        list = FilesystemAssetList.new(
          directory: application.config.bower_directory,
          loadable_files: loadable_files,
          output_directories: output_directories
        )

        application.assets_manager.load_from_list list
      end
    end
  end
end

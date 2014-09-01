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
        load_default_assets_in_bower_directory
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
            stylesheets: %w(stylesheets/middleman-presentation-theme-default)
          )
        else
          application.frontend_components_manager.add(
            application.config.theme
          )
        end
      end

      # Load default components
      def load_default_assets_in_bower_directory
        include_filter = %w(
          .png  .gif .jpg .jpeg .svg .webp
          .eot  .otf .svc .woff .ttf
          .js .coffee
          .css .scss
        ).map { |e| Regexp.new("#{Regexp.escape(e)}$") }

        include_filter << /notes\.html/

        exclude_filter = [/src/, /test/, /demo/]

        output_directories = {
          /notes\.html$/ => Pathname.new('javascripts'),
          /pdf\.css$/ => Pathname.new('stylesheets')
        }

        application.assets_manager.load_from(
          application.config.bower_directory,
          exclude_filter: exclude_filter,
          include_filter: include_filter,
          output_directories: output_directories
        )
      end
    end
  end
end

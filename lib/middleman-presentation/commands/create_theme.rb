# encoding: utf-8
module Middleman
  module Cli
    # This class provides an 'slide' command for the middleman CLI.
    class CreateTheme < Thor
      include Thor::Actions

      namespace :create_theme

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc 'create_theme NAME', 'Create a new presentation theme for middleman-presentation'
      option :stylesheets_directory, default: Middleman::Presentation.config.create_stylesheets_directory, desc: 'Create stylesheets directory'
      option :javascripts_directory, default: Middleman::Presentation.config.create_javascripts_directory, desc: 'Create javascripts directory'
      option :images_directory, default: Middleman::Presentation.config.create_images_directory, desc: 'Create images directory'
      def create_theme(name)
        source_paths << File.expand_path('../../../../templates', __FILE__)

        @theme_name = name

        directory 'presentation_theme', name
      end

      private

      no_commands {
        attr_reader :theme_name
      }
    end
  end
end

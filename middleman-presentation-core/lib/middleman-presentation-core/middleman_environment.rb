# encoding: utf-8
module Middleman
  module Presentation
    # Abstraction for middleman environment
    class MiddlemanEnvironment
      private

      attr_reader :strict, :application_config

      public

      def initialize(strict: true)
        @strict             = strict
        @application_config = Middleman::Presentation.config
      end

      def root_path
        @root_path ||= ConfigurationFile.new.directory
      rescue Errno::ENOENT
        raise Errno::ENOENT, Middleman::Presentation.t('errors.extension_not_activated') if strict

        @root_path = Dir.getwd
      end

      def build_directory
        application_config.build_directory
      end

      def build_path
        File.join(sources_path, application_config.build_directory)
      end

      def stylesheets_directory
        application_config.stylesheets_directory
      end

      def stylesheets_path
        File.join(sources_path, application_config.stylesheets_directory)
      end

      def scripts_directory
        application_config.scripts_directory
      end

      def scripts_path
        File.join(sources_path, application_config.scripts_directory)
      end

      def images_directory
        application_config.images_directory
      end

      def images_path
        File.join(sources_path, application_config.images_directory)
      end

      def fonts_directory
        application_config.fonts_directory
      end

      def fonts_path
        File.join(sources_path, application_config.fonts_directory)
      end

      def sources_directory
        application_config.sources_directory
      end

      def sources_path
        File.join(root_path, application_config.sources_directory)
      end

      def slides_directory
        File.join(application_config.sources_directory, application_config.slides_directory)
      end

      def slides_path
        File.join(root_path, application_config.sources_directory, application_config.slides_directory)
      end

      def bower_directory
        application_config.bower_directory
      end

      def bower_path
        File.join(root_path, application_config.bower_directory)
      end

      private

      def configuration_file
        @configuration_file ||= ConfigurationFile.new
      end

      def server_instance
        @server_instance ||= proc { ::Middleman::Application.server.inst }.call

        fail Thor::Error, Middleman::Presentation.t('errors.extension_not_activated') unless @server_instance.extensions.key? :presentation

        @server_instance
      end

      def presentation_instance
        @presentation_instance ||= server_instance.extensions[:presentation]
      end
    end
  end
end

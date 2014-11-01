# encoding: utf-8
module Middleman
  module Presentation
    # Abstraction for middleman environment
    class MiddlemanEnvironment
      def build_directory
        server_instance.build_dir
      end

      def stylesheets_directory
        server_instance.css_dir
      end

      def scripts_directory
        server_instance.js_dir
      end

      def images_directory
        server_instance.images_dir
      end

      def fonts_directory
        server_instance.fonts_dir
      end

      def sources_directory
        server_instance.source_dir
      end

      def slides_directory
        File.join(sources_directory, Middleman::Presentation.config.slides_directory)
      end

      private

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

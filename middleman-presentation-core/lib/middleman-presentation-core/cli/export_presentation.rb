# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'export presentation' command for the middleman CLI.
      class ExportPresentation < BaseGroup
        include Thor::Actions

        class_option :output_file, desc: Middleman::Presentation.t('views.presentations.export.options.output_file')
        class_option :prefix, desc: Middleman::Presentation.t('views.presentations.export.options.prefix')

        desc Middleman::Presentation.t('views.presentation.export.title')

        def initialize_generator
          enable_debug_mode
        end

        def extract_data
          shared_instance = ::Middleman::Application.server.inst

          @title = Middleman::Presentation.config.title
          @date  = Middleman::Presentation.config.date.to_s
          @source_directory = File.join(shared_instance.root, shared_instance.build_dir)
          @output_file = File.expand_path(
            options.fetch('output_file', ActiveSupport::Inflector.transliterate( @date.to_s + '-' + @title).parameterize + '.zip')
          )

          fail Middleman::Presentation.t('errors.zip_filename_error', name: File.basename(@output_file)) unless @output_file.end_with? '.zip'

          @prefix                = options.fetch('prefix', ActiveSupport::Inflector.transliterate(@date.to_s + '-' + @title.to_s).parameterize + '/')
          @images_directory      = shared_instance.config.images_dir
          @stylesheets_directory = shared_instance.config.css_dir
          @javascripts_directory = shared_instance.config.js_dir
          @fonts_directory       = shared_instance.config.fonts_dir
        end

        def build_presentation
          invoke 'middleman:presentation:cli:build:presentation'
        end

        def create_archive
          Middleman::Presentation.logger.info Middleman::Presentation.t(
            'views.presentation.export.headline',
            title: @title,
            file: @output_file
          )

          Middleman::Presentation::Utils.zip(@source_directory, @output_file, prefix: @prefix)
        end
      end
    end
  end
end

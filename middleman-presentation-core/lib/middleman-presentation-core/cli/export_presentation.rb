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

        def make_middleman_environment_available
          @environment        = MiddlemanEnvironment.new
        end

        def extract_data
          @title = Middleman::Presentation.config.title
          @date  = Middleman::Presentation.config.date.to_s
          @source_directory = @environment.build_path
          @output_file = File.expand_path(
            options.fetch('output_file', ActiveSupport::Inflector.transliterate(@date.to_s + '-' + @title).parameterize + '.zip')
          )

          fail Middleman::Presentation.t('errors.zip_filename_error', name: File.basename(@output_file)) unless @output_file.end_with? '.zip'

          @prefix                = options.fetch('prefix', ActiveSupport::Inflector.transliterate(@date.to_s + '-' + @title.to_s).parameterize + '/')
          @images_directory      = @environment.images_directory
          @stylesheets_directory = @environment.stylesheets_directory
          @javascripts_directory = @environment.scripts_directory
          @fonts_directory       = @environment.fonts_directory
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

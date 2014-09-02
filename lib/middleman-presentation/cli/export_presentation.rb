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

        def add_to_source_path
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def extract_data
          shared_instance = ::Middleman::Application.server.inst

          data = if shared_instance.data.respond_to? :metadata
                   shared_instance.data.metadata.dup
                 else
                   OpenStruct.new(date: Time.now.strftime('%Y%m%d_%H%M%S'), title: 'presentation')
                 end

          @title = data.title
          @source_directory = File.join(shared_instance.root, shared_instance.build_dir)
          @output_file = File.expand_path(
            options.fetch('output_file', ActiveSupport::Inflector.transliterate(data.date.to_s + '-' + data.title.to_s).parameterize + '.zip')
          )

          fail Middleman::Presentation.t('errors.zip_filename_error', name: File.basename(@output_file)) unless @output_file.end_with? '.zip'

          @prefix                = options.fetch('prefix', ActiveSupport::Inflector.transliterate(data.date.to_s + '-' + data.title.to_s).parameterize + '/')
          @images_directory      = shared_instance.config.images_dir
          @stylesheets_directory = shared_instance.config.css_dir
          @javascripts_directory = shared_instance.config.js_dir
          @fonts_directory       = shared_instance.config.fonts_dir

          @rackup_config_file    = File.join shared_instance.build_dir, 'config.ru'
        end

        def build_presentation
          Middleman::Presentation.logger.info Middleman::Presentation.t(
            'views.presentation.export.headline',
            title: @title,
            file: @output_file
          )

          result = run('middleman build', capture: true)
          fail Thor::Error, Middleman::Presentation.t('errors.middleman_build_error', result: result) unless $CHILD_STATUS.exitstatus == 0
        end

        def add_rackup_file
          template 'rackup.config.erb', @rackup_config_file
        end

        def create_archive
          Middleman::Presentation::Utils.zip(@source_directory, @output_file, prefix: @prefix)
        end
      end
    end
  end
end

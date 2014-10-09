# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'build presentation' command for the middleman CLI.
      class BuildPresentation < BaseGroup
        include Thor::Actions

        desc Middleman::Presentation.t('views.presentation.build.title')

        def initialize_generator
          enable_debug_mode
        end

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

          @title                 = data.title
          @images_directory      = shared_instance.images_dir
          @stylesheets_directory = shared_instance.css_dir
          @javascripts_directory = shared_instance.js_dir
          @fonts_directory       = shared_instance.fonts_dir
          @rackup_config_file    = File.join shared_instance.build_dir, 'config.ru'
        end

        def build_presentation
          Middleman::Presentation.logger.info Middleman::Presentation.t(
            'views.presentation.build.headline',
            title: @title
          )

          remove_dir 'build'
          result = run('middleman build --verbose', capture: true)
          fail Thor::Error, Middleman::Presentation.t('errors.middleman_build_error', result: result) unless $CHILD_STATUS.exitstatus == 0
        end

        def add_rackup_file
          template 'rackup.config.erb', @rackup_config_file
        end
      end
    end
  end
end

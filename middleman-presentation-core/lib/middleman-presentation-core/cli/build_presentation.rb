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

        def cleanup
          # before server.inst to prevent having duplicate files
          remove_dir 'build'
        end

        def make_middleman_environment_available
          @environment = MiddlemanEnvironment.new
        end

        def extract_data
          @images_directory      = @environment.images_directory
          @stylesheets_directory = @environment.stylesheets_directory
          @javascripts_directory = @environment.scripts_directory
          @fonts_directory       = @environment.fonts_directory
          @rackup_config_file    = File.join @environment.build_directory, 'config.ru'
        end

        def build_presentation
          Middleman::Presentation.logger.info Middleman::Presentation.t(
            'views.presentation.build.headline',
            title: Middleman::Presentation.config.title
          )

          cmd = []
          cmd << 'middleman build'
          cmd << '--verbose' if options[:debug_mode]

          system cmd.join(' ')
          fail Thor::Error, Middleman::Presentation.t('errors.middleman_build_error', result: '') unless $CHILD_STATUS.exitstatus == 0
        end

        def add_rackup_file
          template 'rackup.config.erb', @rackup_config_file
        end
      end
    end
  end
end

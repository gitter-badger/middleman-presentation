# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'init presentation' command for the middleman CLI.
      class InitApplication < BaseGroup
        include Thor::Actions

        class_option :configuration_file, default: Middleman::Presentation.config.preferred_configuration_file, desc: Middleman::Presentation.t('views.applications.create.options.configuration_file')
        class_option :force, type: :boolean, desc: Middleman::Presentation.t('views.applications.create.options.force')
        class_option :local, type: :boolean, desc: Middleman::Presentation.t('views.applications.create.options.local')

        def initialize_generator
          enable_debug_mode
        end

        def add_to_source_path
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def set_variables_for_templates
          @version            = Middleman::Presentation::VERSION
          @config             = Middleman::Presentation.config
        end

        def write_new_configuration
          file = if options[:local]
                   File.join(root_directory, '.middleman-presentation.yaml')
                 else
                   options[:configuration_file]
                 end

          FileUtils.cp file, "#{file}.bkp" if File.exist?(file) && options[:force]

          if options[:local]
            create_file(
              file,
              Middleman::Presentation.config.to_yaml(keys: Middleman::Presentation.config.exportable_options, remove_blank: true),
              force: options[:force]
            )
          else
            template 'config.yaml.tt', @configuration_file, force: options[:force]
          end
        end
      end
    end
  end
end

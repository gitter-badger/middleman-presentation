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
          @configuration_file = options[:configuration_file]
        end

        def backup_old_configuration
        end

        def write_new_configuration
          if options[:local]
            create_file(
              File.join(root_directory, '.middleman-presentation.yaml'),
              Middleman::Presentation.config.to_yaml(keys: Middleman::Presentation.config.exportable_options, remove_blank: true),
              force: options[:force]
            )
          else
            FileUtils.cp @configuration_file, "#{@configuration_file}.bkp" if File.exist?(@configuration_file) && options[:force]
            template 'config.yaml.tt', @configuration_file , force: options[:force]
          end
        end
      end
    end
  end
end

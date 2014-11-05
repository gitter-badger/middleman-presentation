# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Initialize presentation
      class CreateBundlerConfig < BaseGroup
        include Thor::Actions

        def initialize_generator
          enable_debug_mode
        end

        def add_to_source_path
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def set_variables_for_templates
          @bundle_path = ENV['BUNDLE_PATH']
          @bundle_frozen = ENV['BUNDLE_FROZEN']
          @runtime_environment = Middleman::Presentation.config.runtime_environment
        end

        def add_bundler_config
          template 'bundler_config.tt', File.join(root_directory, '.bundle/config')
        end

        def add_gems_to_gem_file
          template 'Gemfile.tt', File.join(root_directory, 'Gemfile')
        end

        def create_gemlock_file
          Bundler.with_clean_env do
            run 'bundle install'
          end
        end

        no_commands do
          def root_directory
            @root_directory ||= File.expand_path '.'
          end
        end
      end
    end
  end
end


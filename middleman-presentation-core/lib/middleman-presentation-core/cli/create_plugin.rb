# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Create plugin
      class CreatePlugin < BaseGroup
        include Thor::Actions

        desc Middleman::Presentation.t('views.plugins.create.title')

        class_option :author, default: Middleman::Presentation.config.author, desc: Middleman::Presentation.t('views.plugins.create.options.author')
        class_option :email, default: Middleman::Presentation.config.email, desc: Middleman::Presentation.t('views.plugins.create.options.email')
        class_option :homepage, default: Middleman::Presentation.config.homepage, desc: Middleman::Presentation.t('views.plugins.create.options.homepage')
        class_option :year, default: Time.now.strftime('%Y'), desc: Middleman::Presentation.t('views.plugins.create.options.year')
        class_option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: Middleman::Presentation.t('views.plugins.create.options.initialize_git')

        argument :name, desc: Middleman::Presentation.t('views.plugins.create.arguments.name')

        def initialize_generator
          enable_debug_mode
        end

        def add_path_to_source_paths
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def build_plugin_name
          new_name = []
          new_name << name

          @plugin_name = new_name.join('-')
        end

        def create_variables_for_templates
          @plugin_path       = File.expand_path(@plugin_name)
          @plugin_class_name = @plugin_name.split(/-/).map(&:camelcase).join('::')
          @author            = options[:author]
          @year              = options[:year]
          @email             = options[:email]
        end

        def create_plugin
          directory 'plugin', @plugin_name
        end

        def initialize_git
          return unless options[:initialize_git]

          Dir.chdir(@plugin_name) do
            run 'git init'
            run 'git add -A .'
            run "git commit -m \"Initialized #{@plugin_name}\""
          end
        end

        no_commands do
          attr_reader :plugin_name
        end
      end
    end
  end
end

# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Create theme
      class CreateTheme < Thor::Group
        include Thor::Actions

        desc 'Create a new presentation theme for middleman-presentation'

        class_option :theme_prefix, default: Middleman::Presentation.config.theme_prefix, desc: 'Prefix for new theme'
        class_option :stylesheets_directory, default: Middleman::Presentation.config.create_stylesheets_directory, desc: 'Create stylesheets directory'
        class_option :javascripts_directory, default: Middleman::Presentation.config.create_javascripts_directory, desc: 'Create javascripts directory'
        class_option :images_directory, default: Middleman::Presentation.config.create_images_directory, desc: 'Create images directory'
        class_option :author, default: Middleman::Presentation.config.author, desc: 'Author of theme'
        class_option :email, desc: 'E-mail address of author of theme'
        class_option :url, desc: 'Project url'
        class_option :version, default: '0.0.1', required: true, desc: 'Project url'
        class_option :year, default: Time.now.strftime('%Y'), desc: 'Copyright year for theme'
        class_option :license, default: 'MIT', required: true, desc: 'License of theme'
        class_option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: 'Initialize git'
        class_option :clean_css, type: :boolean, default: false, desc: 'Generate clean css without any classes defined'

        argument :name, desc: 'Name of theme'

        def add_path_to_source_paths
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def build_theme_name
          new_name = []
          new_name << options[:theme_prefix] unless options[:theme_prefix].blank?
          new_name << self.name

          @theme_name = new_name.join('-')
        end

        def create_variables_for_templates
          @author     = options[:author]
          @year       = options[:year]
          @license    = options[:license]
          @email      = options[:email]
          @version    = options[:version]
          @clean_css  = options[:clean_css]
        end

        def create_theme_directory
          empty_directory theme_name
        end

        def create_bower_config_file
          template 'presentation_theme/bower.json.tt', File.join(theme_name, 'bower.json')
        end

        def create_asset_directories
          directory('presentation_theme/javascripts', File.join(theme_name, 'javascripts')) if options[:javascripts_directory]
          directory('presentation_theme/stylesheets', File.join(theme_name, 'stylesheets')) if options[:stylesheets_directory]
          directory('presentation_theme/images', File.join(theme_name, 'images')) if options[:images_directory]
        end

        def initialize_git
          return unless options[:initialize_git]

          Dir.chdir(theme_name) do
            run 'git init'
            run 'git add -A .'
            run 'git commit -m Init'
          end
        end

        no_commands do
          attr_reader :theme_name
        end
      end
    end
  end
end
# encoding: utf-8
module Middleman
  module Cli
    # This class provides an 'slide' command for the middleman CLI.
    class Theme < Thor
      include Thor::Actions

      namespace :theme

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc 'theme NAME', 'Create a new presentation theme for middleman-presentation'
      option :prefix, default: Middleman::Presentation.config.theme_prefix, desc: 'Prefix for new theme'
      option :stylesheets_directory, default: Middleman::Presentation.config.create_stylesheets_directory, desc: 'Create stylesheets directory'
      option :javascripts_directory, default: Middleman::Presentation.config.create_javascripts_directory, desc: 'Create javascripts directory'
      option :images_directory, default: Middleman::Presentation.config.create_images_directory, desc: 'Create images directory'
      option :author, default: Middleman::Presentation.config.author, desc: 'Author of theme'
      option :email, desc: 'E-mail address of author of theme'
      option :url, desc: 'Project url'
      option :version, default: '0.0.1', required: true, desc: 'Project url'
      option :year, default: Time.now.strftime('%Y'), desc: 'Copyright year for theme'
      option :license, default: 'MIT', required: true, desc: 'License of theme'
      option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: 'Initialize git'
      option :clean_css, type: :boolean, default: false, desc: 'Generate clean css without any classes defined'
      def theme(name)
        source_paths << File.expand_path('../../../../templates', __FILE__)

        new_name = []
        new_name << options[:theme_prefix] unless options[:theme_prefix].blank?
        new_name << name

        name = new_name.join('-')

        @theme_name = name
        @author     = options[:author]
        @year       = options[:year]
        @license    = options[:license]
        @email      = options[:email]
        @version    = options[:version]
        @clean_css  = options[:clean_css]

        empty_directory name

        template 'presentation_theme/bower.json.tt', File.join(name, 'bower.json')

        directory('presentation_theme/javascripts', File.join(name, 'javascripts')) if options[:javascripts_directory]
        directory('presentation_theme/stylesheets', File.join(name, 'stylesheets')) if options[:stylesheets_directory]
        directory('presentation_theme/images', File.join(name, 'images')) if options[:images_directory]

        Dir.chdir(name) do
          if options[:initialize_git]
            run 'git init'
            run 'git add -A .'
            run 'git commit -m Init'
          end
        end
      end

      no_commands do

        private

        attr_reader :theme_name
      end
    end
  end
end

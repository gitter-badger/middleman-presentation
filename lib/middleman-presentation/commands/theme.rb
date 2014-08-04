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
      option :stylesheets_directory, default: Middleman::Presentation.config.create_stylesheets_directory, desc: 'Create stylesheets directory'
      option :javascripts_directory, default: Middleman::Presentation.config.create_javascripts_directory, desc: 'Create javascripts directory'
      option :images_directory, default: Middleman::Presentation.config.create_images_directory, desc: 'Create images directory'
      option :author, default: Middleman::Presentation.config.author, desc: 'Author of theme'
      option :year, default: Time.now.strftime('%Y'), desc: 'Copyright year for theme'
      option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: 'initialize git'
      def theme(name)
        source_paths << File.expand_path('../../../../templates', __FILE__)

        @theme_name = name
        @author     = options[:author]
        @year       = options[:year]

        empty_directory name
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

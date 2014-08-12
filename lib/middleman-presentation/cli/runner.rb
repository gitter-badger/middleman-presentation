# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Run command
      class Runner < Thor
        desc 'init', 'Initialize system, presentation, ...'
        subcommand 'init', Init

        desc 'show', 'Show information ...'
        subcommand 'show', Show

        register(CreateTheme, 'theme', 'theme NAME', 'Create a new theme named NAMED')

        desc 'config', 'Show configuration'
        option :show_defaults, type: :boolean, desc: 'Show default configuration'
        def config
          if options[:show_defaults]
            capture :stderr do
              puts Middleman::Presentation::PresentationConfig.new(file: nil).to_s
            end
          else
            puts Middleman::Presentation.config.to_s
          end
        end

        desc 'style', 'Show available styles'
        def style
          css_classes = Middleman::Presentation::CssClassExtracter.new.extract Middleman::Presentation.stylable_files, ignore: %w(slides reveal)

          puts "Available css classes in templates used by middleman-presentation:\n"
          css_classes.each { |klass| puts format '  %20s: %s', klass.name, klass.files.to_list }
          puts
        end
      end
    end
  end
end

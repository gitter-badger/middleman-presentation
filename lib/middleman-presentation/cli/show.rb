# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Show < Thor
        include Thor::Actions

        desc 'support_information', 'Collect information for support'
        def support_information
          puts FeduxOrgStdlib::SupportInformation.new.to_s
        end

        desc 'config', 'Show configuration'
        option :defaults, type: :boolean, desc: 'Show default configuration'
        def config
          if options[:defaults]
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

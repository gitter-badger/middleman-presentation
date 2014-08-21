# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Show < Thor
        include Thor::Actions

        desc 'support_information', Middleman::Presentation.t('views.support_informations.show.title')
        def support_information
          puts FeduxOrgStdlib::SupportInformation.new.to_s
        end

        desc 'config', Middleman::Presentation.t('views.configs.show.title')
        option :defaults, type: :boolean, desc: Middleman::Presentation.t('views.configs.show.options.defaults')
        def config
          if options[:defaults]
            capture :stderr do
              puts Middleman::Presentation::PresentationConfig.new(file: nil).to_s
            end
          else
            puts Middleman::Presentation.config.to_s
          end
        end

        desc 'plugins', Middleman::Presentation.t('views.plugins.show.title')
        def plugins
          puts Middleman::Presentation.plugins_manager.to_s
        end

        desc 'style', Middleman::Presentation.t('views.styles.show.title')
        def style
          css_classes = Middleman::Presentation::CssClassExtracter.new.extract Middleman::Presentation.stylable_files, ignore: %w(slides reveal)

          puts Middleman::Presentation.t('views.styles.show.headline')
          css_classes.each { |klass| puts format '  %20s: %s', klass.name, klass.files.to_list }
          puts
        end
      end
    end
  end
end

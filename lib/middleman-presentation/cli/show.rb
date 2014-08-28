# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Show < Base
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
      end
    end
  end
end

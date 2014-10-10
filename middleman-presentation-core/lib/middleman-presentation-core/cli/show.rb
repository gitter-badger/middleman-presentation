# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Show < Base
        include Thor::Actions

        desc 'support_information', Middleman::Presentation.t('views.support_informations.show.title')
        def support_information
          enable_debug_mode

          puts FeduxOrgStdlib::SupportInformation.new(
            headlines: {
              rubygems_information: Middleman::Presentation.t('views.support_informations.show.headline.rubygems_information'),
              system_information: Middleman::Presentation.t('views.support_informations.show.headline.system_information'),
              installed_rubygems: Middleman::Presentation.t('views.support_informations.show.headline.installed_rubygems')
            },
            underline_character: Middleman::Presentation.underline_character
          ).to_s
          puts

          puts Middleman::Presentation.t('views.plugins.list.headline').underline(character: Middleman::Presentation.underline_character)
          puts Middleman::Presentation.plugins_manager.to_s
          puts

          puts Middleman::Presentation.t('views.helpers.list.headline').underline(character: Middleman::Presentation.underline_character)
          puts Middleman::Presentation.helpers_manager.to_s
          puts

          puts Middleman::Presentation.t('views.assets.list.headline').underline(character: Middleman::Presentation.underline_character)
          puts Middleman::Presentation.assets_manager.to_s
          puts

          puts Middleman::Presentation.t('views.frontend_components.list.headline').underline(character: Middleman::Presentation.underline_character)
          puts Middleman::Presentation.frontend_components_manager.to_s
          puts
        end

        desc 'config', Middleman::Presentation.t('views.configs.show.title')
        option :defaults, type: :boolean, desc: Middleman::Presentation.t('views.configs.show.options.defaults')
        def config
          enable_debug_mode

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

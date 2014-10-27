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
          load_assets

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

          puts Middleman::Presentation.t('views.components.list.headline').underline(character: Middleman::Presentation.underline_character)
          puts Middleman::Presentation.components_manager.to_s
          puts
        end

        desc 'version', Middleman::Presentation.t('views.versions.show.title')
        def version
          puts Middleman::Presentation::VERSION
        end

        desc 'config', Middleman::Presentation.t('views.configs.show.title')
        option :defaults, type: :boolean, desc: Middleman::Presentation.t('views.configs.show.options.defaults')
        def config
          enable_debug_mode

          puts format("Used config file: %s\n", Middleman::Presentation.config.file)

          if options[:defaults]
            puts Middleman::Presentation.config.defaults.to_s
          else
            puts Middleman::Presentation.config.to_s
          end
        end
      end
    end
  end
end

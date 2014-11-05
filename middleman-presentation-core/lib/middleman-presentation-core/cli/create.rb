# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Create < Base
        register(CreateTheme, 'theme', 'theme NAME', Middleman::Presentation.t('views.themes.create.title'))
        register(CreatePresentation, 'presentation', 'presentation [DIR]', Middleman::Presentation.t('views.presentations.create.title'))
        register(CreateSlide, 'slide', 'slide [DIR]', Middleman::Presentation.t('views.slides.create.title'))
        register(CreatePlugin, 'plugin', 'plugin NAME', Middleman::Presentation.t('views.plugin.create.title'))
        register(CreateBundlerConfig, 'bundler_config', 'bundler_config', Middleman::Presentation.t('views.bundler_config.create.title'))

        default_command :slide
      end
    end
  end
end

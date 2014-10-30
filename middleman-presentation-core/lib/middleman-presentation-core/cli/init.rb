# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Init < Base
        register(InitApplication, 'application', 'application', Middleman::Presentation.t('views.applications.init.title'))
        register(InitPredefinedSlides, 'predefined_slides', 'predefined_slides', Middleman::Presentation.t('views.predefined_slides.init.title'))
      end
    end
  end
end

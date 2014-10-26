# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Change < Base
        register(ChangeSlide, 'slide', 'slide NAME(S)', Middleman::Presentation.t('views.slides.change.title'))

        default_command :slide
      end
    end
  end
end

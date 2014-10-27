# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Edit < Base
        register(EditSlide, 'slide', 'slide NAME(S)', Middleman::Presentation.t('views.slides.edit.title'))

        default_command :slide
      end
    end
  end
end

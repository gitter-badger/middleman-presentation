require 'middleman/presentation/helpers/version'

module Middleman
  module Presentation
    module Helpers
    end
  end
end

Middleman::Presentation.helpers_manager.add Middleman::Presentation::Helpers::Images
Middleman::Presentation.helpers_manager.add Middleman::Presentation::Helpers::Slides

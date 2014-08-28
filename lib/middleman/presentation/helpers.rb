require 'middleman/presentation/helpers/version'
require 'middleman/presentation/helpers/images'

module Middleman
  module Presentation
    module Helpers
    end
  end
end

Middleman::Presentation.helpers_manager.add Middleman::Presentation::Helpers::Images

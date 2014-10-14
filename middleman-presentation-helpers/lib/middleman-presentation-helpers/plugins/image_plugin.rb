# encoding: utf-8
require 'middleman-presentation-helpers/image'
require 'middleman-presentation-helpers/plugin/image_gallery_plugin'

module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Image Plugin
      module ImagePlugin
        extend PluginApi

        add_helpers Middleman::Presentation::Helpers::Image
      end
    end
  end
end

# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Metadata plugin
      #
      # This is just a plugin for helpers handling metadata in slides
      module MetadataPlugin
        extend PluginApi

        add_helpers Middleman::Presentation::Helpers::Metadata
      end
    end
  end
end

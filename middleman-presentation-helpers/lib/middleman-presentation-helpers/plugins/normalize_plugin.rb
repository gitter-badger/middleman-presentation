# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Slides plugin
      module NormalizePlugin
        extend PluginApi

        add_component(
          name: :'normalize.css',
          version: 'latest',
          importable_files: %w(normalize.css)
        )
      end
    end
  end
end

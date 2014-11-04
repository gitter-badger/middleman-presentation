# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Highlight plugin
      module HighlightPlugin
        extend PluginApi

        loadable_files = [
          %r{.*\.js$}
        ]

        add_component(
          name: :'highlightjs',
          version: 'latest',
          importable_files: %w(zenburn.css),
          loadable_files: loadable_files
        )
      end
    end
  end
end

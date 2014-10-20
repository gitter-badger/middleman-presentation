# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      module JqueryPlugin
        extend PluginApi

        add_component(
          name: :jquery,
          version: '~1.11',
          importable_files: %w(dist/jquery.js)
        )
      end
    end
  end
end

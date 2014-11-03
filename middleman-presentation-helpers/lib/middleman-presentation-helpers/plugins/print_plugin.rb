# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Print plugin
      module PrintPlugin
        extend PluginApi

        add_assets(
          path: File.expand_path('../../../../vendor/assets', __FILE__),
          loadable_files: %w(print.scss)
        )
      end
    end
  end
end

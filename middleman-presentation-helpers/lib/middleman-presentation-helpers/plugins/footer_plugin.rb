# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Slides plugin
      module SlidesPlugin
        extend PluginApi

        add_assets(
          path: File.expand_path('../../../../vendor/assets', __FILE__),
          importable_files: %w(footer.js footer.scss)
        )
      end
    end
  end
end

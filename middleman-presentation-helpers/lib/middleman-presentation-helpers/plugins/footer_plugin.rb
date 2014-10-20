# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      module SlidesPlugin
        extend PluginApi

        add_assets(
          File.expand_path('../../../../vendor/assets', __FILE__),
          importable_files: %w(footer.js footer.scss),
        )
      end
    end
  end
end

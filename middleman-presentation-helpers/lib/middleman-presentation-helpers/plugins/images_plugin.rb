# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Image Plugin
      module ImagePlugin
        extend PluginApi

        add_assets(
          File.expand_path('../../../../vendor/assets', __FILE__),
          importable_files: %w(images.scss),
        )

        add_helpers Middleman::Presentation::Helpers::Image
      end
    end
  end
end

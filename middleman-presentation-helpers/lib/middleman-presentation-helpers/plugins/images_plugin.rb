module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      module ImagesPlugin
        extend PluginApi

        add_assets(
          File.expand_path('../../../../vendor/assets', __FILE__),
          importable_files: %w(images.scss)
        )
      end
    end
  end
end

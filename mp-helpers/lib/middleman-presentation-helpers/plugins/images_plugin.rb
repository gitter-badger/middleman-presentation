module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      module ImagesPlugin
        extend PluginApi

        add_assets(
          File.expand_path('../../../../vendor/assets/images', __FILE__),
          importable_files: %w(images/images.scss)
        )
      end
    end
  end
end

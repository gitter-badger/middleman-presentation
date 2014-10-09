# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      module SlidesPlugin
        extend PluginApi

        add_assets(
          File.expand_path('../../../../vendor/assets/footer', __FILE__),
          importable_files: %w(footer/footer.js footer/footer.scss)
        )

        add_component(
          name: 'jquery',
          version: '~1.11',
          importable_files: %w(dist/jquery.js)
        )
      end
    end
  end
end

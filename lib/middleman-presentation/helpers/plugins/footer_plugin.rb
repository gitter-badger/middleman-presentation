# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      module SlidesPlugin
        extend PluginApi

        add_assets(
          File.expand_path('../../../../vendor/assets/footer', __FILE__)
        )

        add_component(
          name: 'jquery',
          version: '~1.11',
          javascripts: %w(dist/jquery)
        )
      end
    end
  end
end

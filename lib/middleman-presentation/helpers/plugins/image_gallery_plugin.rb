# encoding: utf-8
require 'middleman-presentation/helpers/image_gallery'

module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      module ImageGalleryPlugin
        extend PluginApi

        add_assets(
          File.expand_path('../../../../vendor/assets/image_gallery', __FILE__)
        )

        add_component(
          name: 'jquery',
          version: '~1.11',
          javascripts: %w(dist/jquery)
        )

        add_component(
          name: 'lightbox2',
          github: 'dg-vrnetze/revealjs-lightbox2',
          javascripts: %w(js/lightbox)
        )

        add_helpers Middleman::Presentation::Helpers::ImageGallery
      end
    end
  end
end

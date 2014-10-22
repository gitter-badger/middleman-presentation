# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Image Gallery plugin
      class ImageGalleryPlugin < Plugin
        extend PluginApi

        add_assets(
          path: File.expand_path('../../../../vendor/assets', __FILE__),
          importable_files: %w(image_gallery.scss)
        )

        add_component(
          name: :lightbox2,
          github: 'dg-vrnetze/revealjs-lightbox2',
          importable_files: %w(js/lightbox.js)
        )

        add_helpers Middleman::Presentation::Helpers::ImageGallery
      end
    end
  end
end

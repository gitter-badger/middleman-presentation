# encoding: utf-8
require 'middleman-presentation-helpers/image_gallery.rb'

module Middleman
  module Presentation
    # Helper module
    module Helpers
      # Images helpers
      module Image
        # Create entry for single image
        #
        # @param [String] image
        #   The path to the image, e.g. 'img/image1.png'
        def image(image)
          ImageGallery.image_gallery Array(image), id: SecureRandom.hex
        end
      end
    end
  end
end


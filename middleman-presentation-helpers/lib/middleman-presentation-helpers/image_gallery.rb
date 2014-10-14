module Middleman
  module Presentation
    # Helper module
    module Helpers
      # Images helpers
      module ImageGallery
        # Create image gallery
        #
        # @param [Array] images
        #   An array of image paths, e.g. `img/image.png`
        #
        # @param [String] id
        #   A unique id for your image gallery - unique within your presentation
        def image_gallery(images, id:)
          template = File.read(File.expand_path('../../../../templates/image_gallery.erb', __FILE__)).chomp

          images.each_with_object([]) do |(image, title), memo|
            engine = Erubis::Eruby.new(template)

            memo << engine.result(image_path: image, image_gallery_id: id, title: title)
          end.join("\n")
        end

        module_function :image_gallery
      end
    end
  end
end

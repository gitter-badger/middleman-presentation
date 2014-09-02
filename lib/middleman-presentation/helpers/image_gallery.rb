# encoding: utf-8
module Middleman
  module Presentation
    # Helper module
    module Helpers
      # Images helpers
      module ImageGallery
        # Create image gallery
        def image_gallery(images, image_gallery_id:)
          template = File.read(File.expand_path('../../../../templates/image_gallery.erb', __FILE__)).chomp

          images.each_with_object([]) do |(image, title), memo|
            engine = Erubis::Eruby.new(template)

            memo << engine.result(image_path: image, image_gallery_id: image_gallery_id, title: title)
          end.join("\n")
        end

        # Create entry for single image
        def image(image)
          image_gallery Array(image), image_gallery_id: SecureRandom.hex
        end
      end
    end
  end
end

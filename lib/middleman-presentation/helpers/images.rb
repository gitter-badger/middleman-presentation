# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Create image gallery
      def image_gallery(images, image_gallery_id:, title: nil)
        template = <<-EOS.strip_heredoc
         <a href="<% image_path %>" data-lightbox="<% image_gallery_id %>">
           <img src="<% image_path %>" alt="<% title %>" class="fd-preview-image">
         </a>
        EOS

        images.inject([]) do |memo, image|
          engine = Erubis::Eruby.new(template)
          memo << engine.result(image_path: image, image_gallery_id: image_gallery_id, title: title)

          memo
        end
      end
    end
  end
end

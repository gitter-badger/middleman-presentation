# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Yield slides
      def yield_slides
        Presentation::Slide.clear
        Presentation::Slide.create_from(File.join(root, app.options.slides_directory))

        Presentation::Slide.all.each do |s|
          partial s.relative_to_path(root)
        end
      end

      def image_gallery(images, title = nil, image_gallery_id = nil)
        @image_gallery_id = image_gallery_id ||= SecureRandom.hex

        template = <<-EOS.strip_heredoc
         <a href="<% image_path %>" data-lightbox="<% image_gallery_id %>">
           <img src="<% image_path %>" alt="<% title %>" class="fd-preview-image">
         </a>
        EOS

        images.each do |i|
          engine = Erubis::Eruby.new(template)
          result << engine.result(image: i, image_gallery_id: image_gallery_id, title: title)
        end

      end
    end
  end
end

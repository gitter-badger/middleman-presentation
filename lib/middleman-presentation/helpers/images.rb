# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Create image gallery
      def image_gallery(images, image_gallery_id:)
        template = <<-EOS.strip_heredoc.chomp
         <a href="<%= image_path %>" data-lightbox="<%= image_gallery_id %>">
           <img src="<%= image_path %>"<% if title %> alt="<%= title %>"<% end %> class="fd-preview-image">
         </a>
        EOS

        images.inject([]) do |memo, (image, title)|
          engine = Erubis::Eruby.new(template)
          memo << engine.result(image_path: image, image_gallery_id: image_gallery_id, title: title)

          memo
        end.join("\n")
      end
    end
  end
end

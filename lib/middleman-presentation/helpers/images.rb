# encoding: utf-8
module Middleman
  module Presentation
    # Helper module
    module Helpers
      # Create image gallery
      def image_gallery(images, image_gallery_id:)
        template = <<-EOS.strip_heredoc.chomp
         <a href="<%= image_path %>" data-lightbox="<%= image_gallery_id %>">
           <img src="<%= image_path %>"<% if title %> alt="<%= title %>"<% end %> class="fd-preview-image">
         </a>
        EOS

        images.each_with_object([]) do |memo, (image, title)|
          engine = Erubis::Eruby.new(template)
          memo << engine.result(image_path: image, image_gallery_id: image_gallery_id, title: title)
        end.join("\n")
      end

      # Create entry for single image
      def image(image)
        image_gallery Array(image), image_gallery_id: SecureRandom.hex
      end

      # Find asset for substring
      def find_asset(substring)
        # sprockets.each_logical_path.find { |f| f.to_s.include? substring }
        result = sprockets.each_file.find { |f| f.to_s.include? substring }

        if result.blank?
          I18n.t('errors.asset_not_found', asset: substring)
        else
          result.relative_path_from(Pathname.new(source_dir)).to_s
        end
      end
    end
  end
end

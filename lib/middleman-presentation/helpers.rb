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
    end
  end
end

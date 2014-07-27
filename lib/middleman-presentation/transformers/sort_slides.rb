# encoding: utf-8
module Middleman
  module Presentation
    class SortSlides
      def transform(slides)
        slides.sort
      end
    end
  end
end

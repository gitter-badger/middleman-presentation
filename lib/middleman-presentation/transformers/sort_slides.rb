# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class SortSlides
        def transform(slides)
          slides.sort
        end
      end
    end
  end
end

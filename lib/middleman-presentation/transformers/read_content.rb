# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class ReadContent
        def transform(slides)
          slides.map do |slide|
            slide.content = File.read(slide.path) if slide.exist?

            slide
          end
        end
      end
    end
  end
end

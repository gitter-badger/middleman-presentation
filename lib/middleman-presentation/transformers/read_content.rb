# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      # Read content of slide from filesystem
      class ReadContent
        def transform(slides)
          slides.map do |slide|
            slide.content = File.read(slide.path).chomp if slide.exist?

            slide
          end
        end
      end
    end
  end
end

# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      # Keep slide if it is a file
      class FileKeeper
        def transform(slides)
          slides.keep_if { |slide| File.file? slide.path }
        end
      end
    end
  end
end

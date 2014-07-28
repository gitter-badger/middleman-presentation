# encoding: utf-8
module Middleman
  module Presentation
    class SlideName
      def transform(slides)
        basename = File.basename(slide.name, '.*')

        if slide.extname == '.erb'
          slide.file_name = "#{basename}.html.erb"
          slide.type = :erb
        elsif slide.extname == '.md' or slide.extname == '.markdown'
          slide.file_name = "#{basename}.html.md"
          slide.type = :md
        elsif slide.extname == '.l' or slide.extname == '.liquid'
          slide.file_name = "#{basename}.html.liquid"
          slide.type = :liquid
        else
          slide.file_name = "#{basename}.html.md"
          slide.type = :md
        end

        slide
      end
    end
  end
end
